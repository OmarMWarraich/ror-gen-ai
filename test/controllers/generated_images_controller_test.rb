require "test_helper"

class GeneratedImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get generated_images_show_url
    assert_response :success
  end
end
