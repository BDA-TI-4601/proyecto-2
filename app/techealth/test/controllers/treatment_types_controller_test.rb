require 'test_helper'

class TreatmentTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @treatment_type = treatment_types(:one)
  end

  test "should get index" do
    get treatment_types_url
    assert_response :success
  end

  test "should get new" do
    get new_treatment_type_url
    assert_response :success
  end

  test "should create treatment_type" do
    assert_difference('TreatmentType.count') do
      post treatment_types_url, params: { treatment_type: { name: @treatment_type.name } }
    end

    assert_redirected_to treatment_type_url(TreatmentType.last)
  end

  test "should show treatment_type" do
    get treatment_type_url(@treatment_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_treatment_type_url(@treatment_type)
    assert_response :success
  end

  test "should update treatment_type" do
    patch treatment_type_url(@treatment_type), params: { treatment_type: { name: @treatment_type.name } }
    assert_redirected_to treatment_type_url(@treatment_type)
  end

  test "should destroy treatment_type" do
    assert_difference('TreatmentType.count', -1) do
      delete treatment_type_url(@treatment_type)
    end

    assert_redirected_to treatment_types_url
  end
end
