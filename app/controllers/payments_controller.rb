class PaymentsController < ApplicationController
  def checkout
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'jpy',
          unit_amount: 500, # 500円
          product_data: {
            name: "おまけ記事購入"
          }
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: "#{https://psycho-logic.jp/}?success=true",
      cancel_url: "#{https://psycho-logic.jp/}?canceled=true"
    )
    redirect_to session.url, allow_other_host: true
  end
end
