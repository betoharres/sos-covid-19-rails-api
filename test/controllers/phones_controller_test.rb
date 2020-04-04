require 'test_helper'

class PhonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @phone = phones(:one)
  end

  test "should get index" do
    get phones_url, as: :json
    assert_response :success
  end

  test "should create phone" do
    assert_difference('Phone.count') do
      post phones_url, params: { phone: { is_verified: @phone.is_verified, number: @phone.number } }, as: :json
    end

    assert_response 201
  end

  test "should show phone" do
    get phone_url(@phone), as: :json
    assert_response :success
  end

  test "should update phone" do
    patch phone_url(@phone), params: { phone: { is_verified: @phone.is_verified, number: @phone.number } }, as: :json
    assert_response 200
  end

  test "should destroy phone" do
    assert_difference('Phone.count', -1) do
      delete phone_url(@phone), as: :json
    end

    assert_response 204
  end
end
