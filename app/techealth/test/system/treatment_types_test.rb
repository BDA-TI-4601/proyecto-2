require "application_system_test_case"

class TreatmentTypesTest < ApplicationSystemTestCase
  setup do
    @treatment_type = treatment_types(:one)
  end

  test "visiting the index" do
    visit treatment_types_url
    assert_selector "h1", text: "Treatment Types"
  end

  test "creating a Treatment type" do
    visit treatment_types_url
    click_on "New Treatment Type"

    fill_in "Name", with: @treatment_type.name
    click_on "Create Treatment type"

    assert_text "Treatment type was successfully created"
    click_on "Back"
  end

  test "updating a Treatment type" do
    visit treatment_types_url
    click_on "Edit", match: :first

    fill_in "Name", with: @treatment_type.name
    click_on "Update Treatment type"

    assert_text "Treatment type was successfully updated"
    click_on "Back"
  end

  test "destroying a Treatment type" do
    visit treatment_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Treatment type was successfully destroyed"
  end
end
