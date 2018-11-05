require 'test_helper'

class AppointmentPatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment_patient = appointment_patients(:one)
  end

  test "should get index" do
    get appointment_patients_url
    assert_response :success
  end

  test "should get new" do
    get new_appointment_patient_url
    assert_response :success
  end

  test "should create appointment_patient" do
    assert_difference('AppointmentPatient.count') do
      post appointment_patients_url, params: { appointment_patient: { app_date: @appointment_patient.app_date, area: @appointment_patient.area, id_appointment: @appointment_patient.id_appointment, id_diagnoses: @appointment_patient.id_diagnoses, id_patient: @appointment_patient.id_patient, observation: @appointment_patient.observation, status: @appointment_patient.status } }
    end

    assert_redirected_to appointment_patient_url(AppointmentPatient.last)
  end

  test "should show appointment_patient" do
    get appointment_patient_url(@appointment_patient)
    assert_response :success
  end

  test "should get edit" do
    get edit_appointment_patient_url(@appointment_patient)
    assert_response :success
  end

  test "should update appointment_patient" do
    patch appointment_patient_url(@appointment_patient), params: { appointment_patient: { app_date: @appointment_patient.app_date, area: @appointment_patient.area, id_appointment: @appointment_patient.id_appointment, id_diagnoses: @appointment_patient.id_diagnoses, id_patient: @appointment_patient.id_patient, observation: @appointment_patient.observation, status: @appointment_patient.status } }
    assert_redirected_to appointment_patient_url(@appointment_patient)
  end

  test "should destroy appointment_patient" do
    assert_difference('AppointmentPatient.count', -1) do
      delete appointment_patient_url(@appointment_patient)
    end

    assert_redirected_to appointment_patients_url
  end
end
