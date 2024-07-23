class AccountManagerController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create_portal_session
    session = Stripe::BillingPortal::Session.create({
                                                      customer: current_user.stripe_customer_ref,
                                                      return_url: account_manager_url
                                                    })

    redirect_to session.url, status: 303, allow_other_host: true
  end
end
