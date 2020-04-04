require 'test_helper'

class PatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient = patients(:one)
  end

  test "should get index" do
    get patients_url, as: :json
    assert_response :success
  end

  test "should create patient" do
    assert_difference('Patient.count') do
      post patients_url, params: { patient: { age: @patient.age, cough: @patient.cough, diarrhea: @patient.diarrhea, fever: @patient.fever, headache: @patient.headache, hypogeusia: @patient.hypogeusia, hyposmia: @patient.hyposmia, name: @patient.name, phone_id: @patient.phone_id, short_breath: @patient.short_breath, tired: @patient.tired, weight: @patient.weight } }, as: :json
    end

    assert_response 201
  end

  test "should show patient" do
    get patient_url(@patient), as: :json
    assert_response :success
  end

  test "should update patient" do
    patch patient_url(@patient), params: { patient: { age: @patient.age, cough: @patient.cough, diarrhea: @patient.diarrhea, fever: @patient.fever, headache: @patient.headache, hypogeusia: @patient.hypogeusia, hyposmia: @patient.hyposmia, name: @patient.name, phone_id: @patient.phone_id, short_breath: @patient.short_breath, tired: @patient.tired, weight: @patient.weight } }, as: :json
    assert_response 200
  end

  test "should destroy patient" do
    assert_difference('Patient.count', -1) do
      delete patient_url(@patient), as: :json
    end

    assert_response 204
  end
end
