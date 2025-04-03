class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def stripe
    Rails.logger.info "✅ Webhook受信しました"
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']
  
    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      Rails.logger.warn "⚠️ JSON parse error: #{e.message}"
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.warn "⚠️ Signature verification error: #{e.message}"
      return head :bad_request
    end
  
    Rails.logger.info "✅ Webhook受信: #{event.type}"
  
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
  
      # メタデータからユーザーIDを取得
      user_id = session.metadata.user_id
      user = User.find_by(id: user_id)
  
      if user
        user.increment!(:dice_point, 5000)
        Rails.logger.info "✅ ポイント加算成功: ユーザー#{user.name} に5000ポイント追加"
      else
        Rails.logger.warn "❌ ユーザーが見つかりませんでした: ID=#{user_id}"
      end
    end
  
    head :ok
  end
end