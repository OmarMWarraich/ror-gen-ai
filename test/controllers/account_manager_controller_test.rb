require "test_helper"

class AccountManagerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get account_manager_index_url
    assert_response :success
  end
end
