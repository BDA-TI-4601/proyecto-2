require "application_system_test_case"

class CenterTypesTest < ApplicationSystemTestCase
  setup do
    @center_type = center_types(:one)
  end

  test "visiting the index" do
    visit center_types_url
    assert_selector "h1", text: "Center Types"
  end

  test "creating a Center type" do
    visit center_types_url
    click_on "New Center Type"

    fill_in "Type", with: @center_type.type
    click_on "Create Center type"

    assert_text "Center type was successfully created"
    click_on "Back"
  end

  test "updating a Center type" do
    visit center_types_url
    click_on "Edit", match: :first

    fill_in "Type", with: @center_type.type
    click_on "Update Center type"

    assert_text "Center type was successfully updated"
    click_on "Back"
  end

  test "destroying a Center type" do
    visit center_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Center type was successfully destroyed"
  end
end
