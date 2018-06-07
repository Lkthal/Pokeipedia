class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership",
      amount: 15_00
    }
  end

  def create

      if current_user.customer_id
        customer = Stripe::Customer.retrieve(current_user.customer_id)
      else
        customer = Stripe::Customer.create(
          email: current_user.email,
          card: params[:stripeToken]
        )
      end

      if current_user.premium!
        charge = Stripe::Charge.create(
          customer: customer.id,
          amount: 15_00,
          description: "Premium Membership - #{current_user.email}",
          currency: 'usd'
        )

        flash[:notice] = "Thanks for your contribution, #{current_user.email}! Please continue tp support us."
        redirect_to user_path(current_user) # or wherever
        current_user.premium!

      else
        flash[:error] = "There was an error, please try again"
        redirect_to user_path(current_user)
      end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
