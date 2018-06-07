# Store the environment variables on the Rails.configuration object
Rails.configuration.stripe = {
  PUBLISHABLE_KEY: ENV['STRIPE_PUBLISHABLE_KEY'],
  SECRET_KEY: ENV['STRIPE_SECRET_KEY']
}

# Set our app-stored secret key with Stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]
