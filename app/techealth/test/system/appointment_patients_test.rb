require "application_system_test_case"

class AppointmentPatientsTest < ApplicationSystemTestCase
  setup do
    @appointment_patient = appointment_patients(:one)
  end

  test "visiting the index" do
    visit appointment_patients_url
    assert_selector "h1", text: "Appointment Patients"
  end

  test "creating a Appointment patient" do
    visit appointment_patients_url
    click_on "New Appointment Patient"

    fill_in "App Date", with: @appointment_patient.app_date
    fill_in "Area", with: @appointment_patient.area
    fill_in "Id Appointment", with: @appointment_patient.id_appointment
    fill_in "Id Diagnoses", with: @appointment_patient.id_diagnoses
    fill_in "Id Patient", with: @appointment_patient.id_patient
    fill_in "Observation", with: @appointment_patient.observation
    fill_in "Status", with: @appointment_patient.status
    click_on "Create Appointment patient"

    assert_text "Appointment patient was successfully created"
    click_on "Back"
  end

  test "updating a Appointment patient" do
    visit appointment_patients_url
    click_on "Edit", match: :first

    fill_in "App Date", with: @appointment_patient.app_date
    fill_in "Area", with: @appointment_patient.area
    fill_in "Id Appointment", with: @appointment_patient.id_appointment
    fill_in "Id Diagnoses", with: @appointment_patient.id_diagnoses
    fill_in "Id Patient", with: @appointment_patient.id_patient
    fill_in "Observation", with: @appointment_patient.observation
    fill_in "Status", with: @appointment_patient.status
    click_on "Update Appointment patient"

    assert_text "Appointment patient was successfully updated"
    click_on "Back"
  end

  test "destroying a Appointment patient" do
    visit appointment_patients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Appointment patient was successfully destroyed"
  end
end
