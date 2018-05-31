require 'test_helper'

class ChurchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @church = churches(:one)
  end

  test "should get index" do
    get churches_url, as: :json
    assert_response :success
  end

  test "should create church" do
    assert_difference('Church.count') do
      post churches_url, params: { church: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show church" do
    get church_url(@church), as: :json
    assert_response :success
  end

  test "should update church" do
    patch church_url(@church), params: { church: {  } }, as: :json
    assert_response 200
  end

  test "should destroy church" do
    assert_difference('Church.count', -1) do
      delete church_url(@church), as: :json
    end

    assert_response 204
  end
end
