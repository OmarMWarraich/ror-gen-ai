class SubscriptionsController < ApplicationController
  # before_action :authenticate_user!
  def index
    # if current_user.subscriptions.active.any?
    #   redirect_to account_manager_url and return
    # end

  end

  def success
  end

  def create_checkout_session
    prices = Stripe::Price.list(
      lookup_keys: [params['lookup_key']],
      expand: ['data.product']
    )

    subscription = current_user.subscriptions.find_or_create_by(status: 'pending')

    session = Stripe::Checkout::Session.create({
                                                 mode: 'subscription',
                                                 client_reference_id: subscription.id,
                                                 customer_email: current_user.email,
                                                 line_items: [{
                                                   quantity: 1,
                                                   price: prices.data[0].id
                                                 }],
                                                 success_url: "https://#{ENV.fetch('DOMAIN', 'localhost')}/success?session_id={CHECKOUT_SESSION_ID}",
                                                 cancel_url: root_url
                                               })


    redirect_to session.url, status: 303, allow_other_host: true
  end
end
