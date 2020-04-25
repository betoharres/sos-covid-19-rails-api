require 'test_helper'

class SidekiqApiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sidekiq_api_index_url
    assert_response :success
  end

end
