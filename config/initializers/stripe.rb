if ENV['STRIPE_SECRET_KEY'].present?
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
else
  Rails.logger.warn "Stripe secret key is missing!"
end