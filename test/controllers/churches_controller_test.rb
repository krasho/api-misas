require 'test_helper'

class ChurchesControllerTest < ActionDispatch::IntegrationTest
  test "should get Church" do
    get churches_Church_url
    assert_response :success
  end

end
