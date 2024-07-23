require "test_helper"

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subscriptions_index_url
    assert_response :success
  end

  test "should get success" do
    get subscriptions_success_url
    assert_response :success
  end
end
