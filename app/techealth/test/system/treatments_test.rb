require "application_system_test_case"

class TreatmentsTest < ApplicationSystemTestCase
  setup do
    @treatment = treatments(:one)
  end

  test "visiting the index" do
    visit treatments_url
    assert_selector "h1", text: "Treatments"
  end

  test "creating a Treatment" do
    visit treatments_url
    click_on "New Treatment"

    fill_in "Days", with: @treatment.days
    fill_in "Dosis", with: @treatment.dosis
    fill_in "Id Treatment", with: @treatment.id_treatment
    fill_in "Name", with: @treatment.name
    fill_in "Secondary Effects", with: @treatment.secondary_effects
    fill_in "Total", with: @treatment.total
    fill_in "Type", with: @treatment.type
    click_on "Create Treatment"

    assert_text "Treatment was successfully created"
    click_on "Back"
  end

  test "updating a Treatment" do
    visit treatments_url
    click_on "Edit", match: :first

    fill_in "Days", with: @treatment.days
    fill_in "Dosis", with: @treatment.dosis
    fill_in "Id Treatment", with: @treatment.id_treatment
    fill_in "Name", with: @treatment.name
    fill_in "Secondary Effects", with: @treatment.secondary_effects
    fill_in "Total", with: @treatment.total
    fill_in "Type", with: @treatment.type
    click_on "Update Treatment"

    assert_text "Treatment was successfully updated"
    click_on "Back"
  end

  test "destroying a Treatment" do
    visit treatments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Treatment was successfully destroyed"
  end
end
