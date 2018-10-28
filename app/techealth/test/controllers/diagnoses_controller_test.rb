require 'test_helper'

class DiagnosesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @diagnosis = diagnoses(:one)
  end

  test "should get index" do
    get diagnoses_url
    assert_response :success
  end

  test "should get new" do
    get new_diagnosis_url
    assert_response :success
  end

  test "should create diagnosis" do
    assert_difference('Diagnose.count') do
      post diagnoses_url, params: { diagnosis: { id_diagnose: @diagnosis.id_diagnose, id_treatments: @diagnosis.id_treatments, level: @diagnosis.level, name: @diagnosis.name, observations: @diagnosis.observations, symptoms: @diagnosis.symptoms } }
    end

    assert_redirected_to diagnosis_url(Diagnose.last)
  end

  test "should show diagnosis" do
    get diagnosis_url(@diagnosis)
    assert_response :success
  end

  test "should get edit" do
    get edit_diagnosis_url(@diagnosis)
    assert_response :success
  end

  test "should update diagnosis" do
    patch diagnosis_url(@diagnosis), params: { diagnosis: { id_diagnose: @diagnosis.id_diagnose, id_treatments: @diagnosis.id_treatments, level: @diagnosis.level, name: @diagnosis.name, observations: @diagnosis.observations, symptoms: @diagnosis.symptoms } }
    assert_redirected_to diagnosis_url(@diagnosis)
  end

  test "should destroy diagnosis" do
    assert_difference('Diagnose.count', -1) do
      delete diagnosis_url(@diagnosis)
    end

    assert_redirected_to diagnoses_url
  end
end
