require 'test_helper'

class PatientStateControllerTest < ActionDispatch::IntegrationTest
  test "should get call" do
    get patient_state_call_url
    assert_response :success
  end

  test "should get visit" do
    get patient_state_visit_url
    assert_response :success
  end

  test "should get discard" do
    get patient_state_discard_url
    assert_response :success
  end

  test "should get infect" do
    get patient_state_infect_url
    assert_response :success
  end

end
