require "application_system_test_case"

class AttentionCentersTest < ApplicationSystemTestCase
  setup do
    @attention_center = attention_centers(:one)
  end

  test "visiting the index" do
    visit attention_centers_url
    assert_selector "h1", text: "Attention Centers"
  end

  test "creating a Attention center" do
    visit attention_centers_url
    click_on "New Attention Center"

    fill_in "Capacity", with: @attention_center.capacity
    fill_in "Center Type", with: @attention_center.center_type
    fill_in "Code", with: @attention_center.code
    fill_in "Name", with: @attention_center.name
    fill_in "Place", with: @attention_center.place
    click_on "Create Attention center"

    assert_text "Attention center was successfully created"
    click_on "Back"
  end

  test "updating a Attention center" do
    visit attention_centers_url
    click_on "Edit", match: :first

    fill_in "Capacity", with: @attention_center.capacity
    fill_in "Center Type", with: @attention_center.center_type
    fill_in "Code", with: @attention_center.code
    fill_in "Name", with: @attention_center.name
    fill_in "Place", with: @attention_center.place
    click_on "Update Attention center"

    assert_text "Attention center was successfully updated"
    click_on "Back"
  end

  test "destroying a Attention center" do
    visit attention_centers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Attention center was successfully destroyed"
  end
end
