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
          unit_amount: 100,
          product_data: {
            name: '100円分のダイスポイント'
          }
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: "https://psycho-logic.jp/success",
      cancel_url: "https://psycho-logic.jp/cancel",
      metadata: {
      user_id: current_user.id
      } 
    )
  
    redirect_to session.url, allow_other_host: true
  end

  def success
    session_id = params[:session_id] # Stripe Checkoutから受け取る

    # すでに処理済みならスキップ（重複防止）
    return if PointLog.where(user_id:current_user,craete_at:Date.today).exist?

    @user = User.find(current_user.id)
    @user.dice_point += 1000
    @user.save
    PointLog.create(
      user_id: @user.id,
      service_name: "その他",
      category: "ポイントの購入",
      dice_point: 1000,
      service_id: session_id
    )
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