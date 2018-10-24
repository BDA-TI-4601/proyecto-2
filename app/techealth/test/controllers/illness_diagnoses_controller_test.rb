require 'test_helper'

class IllnessDiagnosesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @illness_diagnosis = illness_diagnoses(:one)
  end

  test "should get index" do
    get illness_diagnoses_url
    assert_response :success
  end

  test "should get new" do
    get new_illness_diagnosis_url
    assert_response :success
  end

  test "should create illness_diagnosis" do
    assert_difference('IllnessDiagnosis.count') do
      post illness_diagnoses_url, params: { illness_diagnosis: { name: @illness_diagnosis.name, symptoms: @illness_diagnosis.symptoms, treatments: @illness_diagnosis.treatments } }
    end

    assert_redirected_to illness_diagnosis_url(IllnessDiagnosis.last)
  end

  test "should show illness_diagnosis" do
    get illness_diagnosis_url(@illness_diagnosis)
    assert_response :success
  end

  test "should get edit" do
    get edit_illness_diagnosis_url(@illness_diagnosis)
    assert_response :success
  end

  test "should update illness_diagnosis" do
    patch illness_diagnosis_url(@illness_diagnosis), params: { illness_diagnosis: { name: @illness_diagnosis.name, symptoms: @illness_diagnosis.symptoms, treatments: @illness_diagnosis.treatments } }
    assert_redirected_to illness_diagnosis_url(@illness_diagnosis)
  end

  test "should destroy illness_diagnosis" do
    assert_difference('IllnessDiagnosis.count', -1) do
      delete illness_diagnosis_url(@illness_diagnosis)
    end

    assert_redirected_to illness_diagnoses_url
  end
end
