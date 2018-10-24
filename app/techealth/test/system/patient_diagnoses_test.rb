require "application_system_test_case"

class PatientDiagnosesTest < ApplicationSystemTestCase
  setup do
    @patient_diagnosis = patient_diagnoses(:one)
  end

  test "visiting the index" do
    visit patient_diagnoses_url
    assert_selector "h1", text: "Patient Diagnoses"
  end

  test "creating a Patient diagnose" do
    visit patient_diagnoses_url
    click_on "New Patient Diagnose"

    fill_in "Diagnose", with: @patient_diagnosis.diagnose_id
    fill_in "Id Patient", with: @patient_diagnosis.id_patient
    fill_in "Level", with: @patient_diagnosis.level
    fill_in "Observation", with: @patient_diagnosis.observation
    click_on "Create Patient diagnose"

    assert_text "Patient diagnose was successfully created"
    click_on "Back"
  end

  test "updating a Patient diagnose" do
    visit patient_diagnoses_url
    click_on "Edit", match: :first

    fill_in "Diagnose", with: @patient_diagnosis.diagnose_id
    fill_in "Id Patient", with: @patient_diagnosis.id_patient
    fill_in "Level", with: @patient_diagnosis.level
    fill_in "Observation", with: @patient_diagnosis.observation
    click_on "Update Patient diagnose"

    assert_text "Patient diagnose was successfully updated"
    click_on "Back"
  end

  test "destroying a Patient diagnose" do
    visit patient_diagnoses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Patient diagnose was successfully destroyed"
  end
end
