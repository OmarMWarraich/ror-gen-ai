require "test_helper"

class Txt2ImgsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get txt2_imgs_index_url
    assert_response :success
  end
end
