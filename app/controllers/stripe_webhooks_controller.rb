class StripeWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :webhook

  def webhook
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV.fetch('STRIPE_WEBHOOK_SECRET')
      )
    rescue JSON::ParserError => e
      # Invalid payload
      Rails.logger.error "⚠️  Webhook JSON parse error: #{e.message}"
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      Rails.logger.error "⚠️  Webhook signature verification error: #{e.message}"
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object

      if session.client_reference_id.present?
        subscription = Subscription.find(session.client_reference_id)
        subscription.user.update(stripe_customer_ref: session.customer)
        subscription.update!(stripe_customer_ref: session.customer, stripe_subscription_ref: session.subscription)
      end
    when 'customer.subscription.created'
      stripe_subscription = event.data.object

      subscription = Subscription.find_by(stripe_subscription_ref: stripe_subscription.id)
      subscription.update!(status: stripe_subscription.status,
                           paid_until: Time.at(stripe_subscription.current_period_end))
    when 'customer.subscription.deleted'
      stripe_subscription = event.data.object
      subscription = Subscription.find_by(stripe_subscription_ref: stripe_subscription.id)
      subscription.update!(status: 'canceled', paid_until: nil)
    when 'customer.subscription.updated'
      stripe_subscription = event.data.object
      subscription = Subscription.find_by(stripe_subscription_ref: stripe_subscription.id)
      subscription.update!(status: stripe_subscription.status,
                           paid_until: Time.at(stripe_subscription.current_period_end))
    # ... handle other event types
    else
      puts "Unhandled event type: #{event.type}"
    end
  end
end
