require "application_system_test_case"

class IllnessDiagnosesTest < ApplicationSystemTestCase
  setup do
    @illness_diagnosis = illness_diagnoses(:one)
  end

  test "visiting the index" do
    visit illness_diagnoses_url
    assert_selector "h1", text: "Illness Diagnoses"
  end

  test "creating a Illness diagnosis" do
    visit illness_diagnoses_url
    click_on "New Illness Diagnosis"

    fill_in "Name", with: @illness_diagnosis.name
    fill_in "Symptoms", with: @illness_diagnosis.symptoms
    fill_in "Treatments", with: @illness_diagnosis.treatments
    click_on "Create Illness diagnosis"

    assert_text "Illness diagnosis was successfully created"
    click_on "Back"
  end

  test "updating a Illness diagnosis" do
    visit illness_diagnoses_url
    click_on "Edit", match: :first

    fill_in "Name", with: @illness_diagnosis.name
    fill_in "Symptoms", with: @illness_diagnosis.symptoms
    fill_in "Treatments", with: @illness_diagnosis.treatments
    click_on "Update Illness diagnosis"

    assert_text "Illness diagnosis was successfully updated"
    click_on "Back"
  end

  test "destroying a Illness diagnosis" do
    visit illness_diagnoses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Illness diagnosis was successfully destroyed"
  end
end
