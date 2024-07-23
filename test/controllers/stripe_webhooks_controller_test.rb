require "test_helper"

class StripeWebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get webhook" do
    get stripe_webhooks_webhook_url
    assert_response :success
  end
end
