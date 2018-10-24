require "application_system_test_case"

class TreatmentPacientsTest < ApplicationSystemTestCase
  setup do
    @treatment_pacient = treatment_pacients(:one)
  end

  test "visiting the index" do
    visit treatment_pacients_url
    assert_selector "h1", text: "Treatment Pacients"
  end

  test "creating a Treatment pacient" do
    visit treatment_pacients_url
    click_on "New Treatment Pacient"

    fill_in "Days", with: @treatment_pacient.days
    fill_in "Dosis", with: @treatment_pacient.dosis
    fill_in "Id Patient", with: @treatment_pacient.id_patient
    fill_in "Secundary Effects", with: @treatment_pacient.secundary_effects
    click_on "Create Treatment pacient"

    assert_text "Treatment pacient was successfully created"
    click_on "Back"
  end

  test "updating a Treatment pacient" do
    visit treatment_pacients_url
    click_on "Edit", match: :first

    fill_in "Days", with: @treatment_pacient.days
    fill_in "Dosis", with: @treatment_pacient.dosis
    fill_in "Id Patient", with: @treatment_pacient.id_patient
    fill_in "Secundary Effects", with: @treatment_pacient.secundary_effects
    click_on "Update Treatment pacient"

    assert_text "Treatment pacient was successfully updated"
    click_on "Back"
  end

  test "destroying a Treatment pacient" do
    visit treatment_pacients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Treatment pacient was successfully destroyed"
  end
end
