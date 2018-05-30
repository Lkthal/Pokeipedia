# Store the environment variables on the Rails.configuration object
Rails.configuration.stripe = {
  PUBLISHABLE_KEY=pk_test_UMtFagEq7D9NIKcPa1xUDu7k
  SECRET_KEY=sk_test_fyChJBJuq5rWV1mh9NJBZAVs
}

# Set our app-stored secret key with Stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]
