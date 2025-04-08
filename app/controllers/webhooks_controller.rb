class WebhooksController < ApplicationController
  # 認証トークン検証をスキップ（Webhookは外部からアクセスされるため）
  skip_before_action :verify_authenticity_token

  def stripe
    Rails.logger.info "✅ Webhook受信開始"

    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      Rails.logger.warn "⚠️ JSON parse error: #{e.message}"
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.warn "❌ Webhook署名検証エラー: #{e.message}"
      return head :bad_request
    end

    Rails.logger.info "📩 受信イベントタイプ: #{event.type}"

    case event.type
    when 'checkout.session.completed'
      session = event.data.object

      # メタデータからユーザーIDを取得
      user_id = session.metadata.user_id
      user = User.find_by(id: user_id)

      if user
        user.increment!(:dice_point, 2000)

        # ポイントログを作成（任意）
        PointLog.create!(
          user_id: user.id,
          service_name: "その他",
          category: "ポイントの購入",
          dice_point: 2000,
          service_id: nil
        )

        Rails.logger.info "✅ ユーザー #{user.name} に2000ポイント追加完了"
      else
        Rails.logger.warn "❌ 該当ユーザーが見つかりませんでした: ID=#{user_id}"
      end
    else
      Rails.logger.info "ℹ️ 他イベント: #{event.type} は未処理"
    end

    head :ok
  end
end