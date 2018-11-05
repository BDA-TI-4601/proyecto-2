require "application_system_test_case"

class DoctorsTest < ApplicationSystemTestCase
  setup do
    @doctor = doctors(:one)
  end

  test "visiting the index" do
    visit doctors_url
    assert_selector "h1", text: "Doctors"
  end

  test "creating a Doctor" do
    visit doctors_url
    click_on "New Doctor"

    fill_in "App Date", with: @doctor.app_date
    fill_in "Area", with: @doctor.area
    fill_in "Id Appointment", with: @doctor.id_appointment
    fill_in "Id Diagnoses", with: @doctor.id_diagnoses
    fill_in "Id Patient Integer", with: @doctor.id_patient_integer
    fill_in "Observation", with: @doctor.observation
    fill_in "Status", with: @doctor.status
    click_on "Create Doctor"

    assert_text "Doctor was successfully created"
    click_on "Back"
  end

  test "updating a Doctor" do
    visit doctors_url
    click_on "Edit", match: :first

    fill_in "App Date", with: @doctor.app_date
    fill_in "Area", with: @doctor.area
    fill_in "Id Appointment", with: @doctor.id_appointment
    fill_in "Id Diagnoses", with: @doctor.id_diagnoses
    fill_in "Id Patient Integer", with: @doctor.id_patient_integer
    fill_in "Observation", with: @doctor.observation
    fill_in "Status", with: @doctor.status
    click_on "Update Doctor"

    assert_text "Doctor was successfully updated"
    click_on "Back"
  end

  test "destroying a Doctor" do
    visit doctors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Doctor was successfully destroyed"
  end
end
