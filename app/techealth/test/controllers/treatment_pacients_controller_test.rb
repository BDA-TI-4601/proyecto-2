require 'test_helper'

class TreatmentPacientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @treatment_pacient = treatment_pacients(:one)
  end

  test "should get index" do
    get treatment_pacients_url
    assert_response :success
  end

  test "should get new" do
    get new_treatment_pacient_url
    assert_response :success
  end

  test "should create treatment_pacient" do
    assert_difference('TreatmentPacient.count') do
      post treatment_pacients_url, params: { treatment_pacient: { days: @treatment_pacient.days, dosis: @treatment_pacient.dosis, id_patient: @treatment_pacient.id_patient, secundary_effects: @treatment_pacient.secundary_effects } }
    end

    assert_redirected_to treatment_pacient_url(TreatmentPacient.last)
  end

  test "should show treatment_pacient" do
    get treatment_pacient_url(@treatment_pacient)
    assert_response :success
  end

  test "should get edit" do
    get edit_treatment_pacient_url(@treatment_pacient)
    assert_response :success
  end

  test "should update treatment_pacient" do
    patch treatment_pacient_url(@treatment_pacient), params: { treatment_pacient: { days: @treatment_pacient.days, dosis: @treatment_pacient.dosis, id_patient: @treatment_pacient.id_patient, secundary_effects: @treatment_pacient.secundary_effects } }
    assert_redirected_to treatment_pacient_url(@treatment_pacient)
  end

  test "should destroy treatment_pacient" do
    assert_difference('TreatmentPacient.count', -1) do
      delete treatment_pacient_url(@treatment_pacient)
    end

    assert_redirected_to treatment_pacients_url
  end
end
