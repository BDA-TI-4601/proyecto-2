require 'test_helper'

class PatientDiagnosesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient_diagnosis = patient_diagnoses(:one)
  end

  test "should get index" do
    get patient_diagnoses_url
    assert_response :success
  end

  test "should get new" do
    get new_patient_diagnosis_url
    assert_response :success
  end

  test "should create patient_diagnosis" do
    assert_difference('PatientDiagnose.count') do
      post patient_diagnoses_url, params: { patient_diagnosis: { diagnose_id: @patient_diagnosis.diagnose_id, id_patient: @patient_diagnosis.id_patient, level: @patient_diagnosis.level, observation: @patient_diagnosis.observation } }
    end

    assert_redirected_to patient_diagnosis_url(PatientDiagnose.last)
  end

  test "should show patient_diagnosis" do
    get patient_diagnosis_url(@patient_diagnosis)
    assert_response :success
  end

  test "should get edit" do
    get edit_patient_diagnosis_url(@patient_diagnosis)
    assert_response :success
  end

  test "should update patient_diagnosis" do
    patch patient_diagnosis_url(@patient_diagnosis), params: { patient_diagnosis: { diagnose_id: @patient_diagnosis.diagnose_id, id_patient: @patient_diagnosis.id_patient, level: @patient_diagnosis.level, observation: @patient_diagnosis.observation } }
    assert_redirected_to patient_diagnosis_url(@patient_diagnosis)
  end

  test "should destroy patient_diagnosis" do
    assert_difference('PatientDiagnose.count', -1) do
      delete patient_diagnosis_url(@patient_diagnosis)
    end

    assert_redirected_to patient_diagnoses_url
  end
end
