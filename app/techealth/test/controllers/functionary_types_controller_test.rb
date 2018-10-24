require 'test_helper'

class FunctionaryTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @functionary_type = functionary_types(:one)
  end

  test "should get index" do
    get functionary_types_url
    assert_response :success
  end

  test "should get new" do
    get new_functionary_type_url
    assert_response :success
  end

  test "should create functionary_type" do
    assert_difference('FunctionaryType.count') do
      post functionary_types_url, params: { functionary_type: { name: @functionary_type.name } }
    end

    assert_redirected_to functionary_type_url(FunctionaryType.last)
  end

  test "should show functionary_type" do
    get functionary_type_url(@functionary_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_functionary_type_url(@functionary_type)
    assert_response :success
  end

  test "should update functionary_type" do
    patch functionary_type_url(@functionary_type), params: { functionary_type: { name: @functionary_type.name } }
    assert_redirected_to functionary_type_url(@functionary_type)
  end

  test "should destroy functionary_type" do
    assert_difference('FunctionaryType.count', -1) do
      delete functionary_type_url(@functionary_type)
    end

    assert_redirected_to functionary_types_url
  end
end
