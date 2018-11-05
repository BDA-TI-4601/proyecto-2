require 'test_helper'

class FunctionariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @functionary = functionaries(:one)
  end

  test "should get index" do
    get functionaries_url
    assert_response :success
  end

  test "should get new" do
    get new_functionary_url
    assert_response :success
  end

  test "should create functionary" do
    assert_difference('Functionary.count') do
      post functionaries_url, params: { functionary: { area: @functionary.area, identification: @functionary.identification, init_date: @functionary.init_date, institution: @functionary.institution, name: @functionary.name, type: @functionary.type } }
    end

    assert_redirected_to functionary_url(Functionary.last)
  end

  test "should show functionary" do
    get functionary_url(@functionary)
    assert_response :success
  end

  test "should get edit" do
    get edit_functionary_url(@functionary)
    assert_response :success
  end

  test "should update functionary" do
    patch functionary_url(@functionary), params: { functionary: { area: @functionary.area, identification: @functionary.identification, init_date: @functionary.init_date, institution: @functionary.institution, name: @functionary.name, type: @functionary.type } }
    assert_redirected_to functionary_url(@functionary)
  end

  test "should destroy functionary" do
    assert_difference('Functionary.count', -1) do
      delete functionary_url(@functionary)
    end

    assert_redirected_to functionaries_url
  end
end
