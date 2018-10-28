require "application_system_test_case"

class FunctionariesTest < ApplicationSystemTestCase
  setup do
    @functionary = functionaries(:one)
  end

  test "visiting the index" do
    visit functionaries_url
    assert_selector "h1", text: "Functionaries"
  end

  test "creating a Functionary" do
    visit functionaries_url
    click_on "New Functionary"

    fill_in "Area", with: @functionary.area
    fill_in "Identification", with: @functionary.identification
    fill_in "Init Date", with: @functionary.init_date
    fill_in "Institution", with: @functionary.institution
    fill_in "Name", with: @functionary.name
    fill_in "Type", with: @functionary.type
    click_on "Create Functionary"

    assert_text "Functionary was successfully created"
    click_on "Back"
  end

  test "updating a Functionary" do
    visit functionaries_url
    click_on "Edit", match: :first

    fill_in "Area", with: @functionary.area
    fill_in "Identification", with: @functionary.identification
    fill_in "Init Date", with: @functionary.init_date
    fill_in "Institution", with: @functionary.institution
    fill_in "Name", with: @functionary.name
    fill_in "Type", with: @functionary.type
    click_on "Update Functionary"

    assert_text "Functionary was successfully updated"
    click_on "Back"
  end

  test "destroying a Functionary" do
    visit functionaries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Functionary was successfully destroyed"
  end
end
