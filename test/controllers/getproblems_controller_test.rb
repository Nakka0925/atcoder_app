require "test_helper"

class GetproblemsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get getproblems_top_url
    assert_response :success
  end
end
