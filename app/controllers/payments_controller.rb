class PaymentsController < ApplicationController

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
      success_url: "https://shiny-umbrella-j9vrp4p9vx2qrp7-3000.app.github.dev/success",
      cancel_url: "https://shiny-umbrella-j9vrp4p9vx2qrp7-3000.app.github.dev/cancel",
      metadata: {
      user_id: current_user.id
      } 
    )
  
    redirect_to session.url, allow_other_host: true
  end
end