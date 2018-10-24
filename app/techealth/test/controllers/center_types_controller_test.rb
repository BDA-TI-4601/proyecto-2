require 'test_helper'

class CenterTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @center_type = center_types(:one)
  end

  test "should get index" do
    get center_types_url
    assert_response :success
  end

  test "should get new" do
    get new_center_type_url
    assert_response :success
  end

  test "should create center_type" do
    assert_difference('CenterType.count') do
      post center_types_url, params: { center_type: { type: @center_type.type } }
    end

    assert_redirected_to center_type_url(CenterType.last)
  end

  test "should show center_type" do
    get center_type_url(@center_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_center_type_url(@center_type)
    assert_response :success
  end

  test "should update center_type" do
    patch center_type_url(@center_type), params: { center_type: { type: @center_type.type } }
    assert_redirected_to center_type_url(@center_type)
  end

  test "should destroy center_type" do
    assert_difference('CenterType.count', -1) do
      delete center_type_url(@center_type)
    end

    assert_redirected_to center_types_url
  end
end
