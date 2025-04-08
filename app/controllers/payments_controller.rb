class PaymentsController < ApplicationController
  before_action :logged_in_user, only: [:success]
  before_action :correct_user,   only: [:success]

  def checkout
    Rails.logger.info "✅ checkoutアクションに入りました"
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'jpy',
          unit_amount: 200,
          product_data: {
            name: '200円分のダイスポイント'
          }
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: "https://psycho-logic.jp/success",
      cancel_url: "https://psycho-logic.jp/cancel",
      metadata: {
      user_id: current_user.id
      },
      custom_text: {
      submit: {
        message: 'psycho-logicでお支払い'
      }
    }
  )
    redirect_to session.url, allow_other_host: true
  end

  def success
    session_id = params[:session_id]
  
    # Stripeから返ってきた決済セッションを使って、重複防止
    already_logged_today = PointLog.exists?(
      user_id: current_user.id,
      service_name: "その他",
      category: "ポイントの購入",
      created_at: Time.zone.today.all_day
    )
  
    return if already_logged_today
  
    # Stripeからセッションを取得（必要なら）
    session = Stripe::Checkout::Session.retrieve(session_id)
  
    # 購入確認（本当に支払いが済んでるか）
    if session.payment_status == "paid"
      current_user.increment!(:dice_point, 2000)
  
      PointLog.create!(
        user_id: current_user.id,
        service_name: "その他",
        category: "ポイントの購入",
        dice_point: 2000,
        service_id: session_id
      )
    end
  end

  private
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(current_user.id)
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
end