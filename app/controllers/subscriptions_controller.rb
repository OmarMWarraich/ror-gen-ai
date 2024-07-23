class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def success
  end

  def create_checkout_session
    prices = Stripe::Price.list(
    lookup_keys: [params['lookup_key']],
    expand: ['data.product']
  )

    subscription = current_user.subscriptions.find_or_create_by(status: "pending")

    session = Stripe::Checkout::Session.create({
                                                mode: 'subscription',
                                                client_reference_id: subscription.id,
                                                customer_email: current_user.email,
                                                line_items: [{
                                                  quantity: 1,
                                                  price: prices.data[0].id
                                                }],
                                                success_url: "http://localhost:3000" + '/success.html?session_id={CHECKOUT_SESSION_ID}',
                                                cancel_url: root_url,
    })

    redirect_to session.url, 303, allow_other_host: true
  end
end
