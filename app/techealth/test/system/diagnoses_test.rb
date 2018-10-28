require "application_system_test_case"

class DiagnosesTest < ApplicationSystemTestCase
  setup do
    @diagnosis = diagnoses(:one)
  end

  test "visiting the index" do
    visit diagnoses_url
    assert_selector "h1", text: "Diagnoses"
  end

  test "creating a Diagnose" do
    visit diagnoses_url
    click_on "New Diagnose"

    fill_in "Id Diagnose", with: @diagnosis.id_diagnose
    fill_in "Id Treatments", with: @diagnosis.id_treatments
    fill_in "Level", with: @diagnosis.level
    fill_in "Name", with: @diagnosis.name
    fill_in "Observations", with: @diagnosis.observations
    fill_in "Symptoms", with: @diagnosis.symptoms
    click_on "Create Diagnose"

    assert_text "Diagnose was successfully created"
    click_on "Back"
  end

  test "updating a Diagnose" do
    visit diagnoses_url
    click_on "Edit", match: :first

    fill_in "Id Diagnose", with: @diagnosis.id_diagnose
    fill_in "Id Treatments", with: @diagnosis.id_treatments
    fill_in "Level", with: @diagnosis.level
    fill_in "Name", with: @diagnosis.name
    fill_in "Observations", with: @diagnosis.observations
    fill_in "Symptoms", with: @diagnosis.symptoms
    click_on "Update Diagnose"

    assert_text "Diagnose was successfully updated"
    click_on "Back"
  end

  test "destroying a Diagnose" do
    visit diagnoses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Diagnose was successfully destroyed"
  end
end
