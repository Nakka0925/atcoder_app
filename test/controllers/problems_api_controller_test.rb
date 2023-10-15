require "test_helper"

class ProblemsApiControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get problems_api_new_url
    assert_response :success
  end
end
