require 'test_helper'

class AttentionCentersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attention_center = attention_centers(:one)
  end

  test "should get index" do
    get attention_centers_url
    assert_response :success
  end

  test "should get new" do
    get new_attention_center_url
    assert_response :success
  end

  test "should create attention_center" do
    assert_difference('AttentionCenter.count') do
      post attention_centers_url, params: { attention_center: { capacity: @attention_center.capacity, center_type: @attention_center.center_type, code: @attention_center.code, name: @attention_center.name, place: @attention_center.place } }
    end

    assert_redirected_to attention_center_url(AttentionCenter.last)
  end

  test "should show attention_center" do
    get attention_center_url(@attention_center)
    assert_response :success
  end

  test "should get edit" do
    get edit_attention_center_url(@attention_center)
    assert_response :success
  end

  test "should update attention_center" do
    patch attention_center_url(@attention_center), params: { attention_center: { capacity: @attention_center.capacity, center_type: @attention_center.center_type, code: @attention_center.code, name: @attention_center.name, place: @attention_center.place } }
    assert_redirected_to attention_center_url(@attention_center)
  end

  test "should destroy attention_center" do
    assert_difference('AttentionCenter.count', -1) do
      delete attention_center_url(@attention_center)
    end

    assert_redirected_to attention_centers_url
  end
end
