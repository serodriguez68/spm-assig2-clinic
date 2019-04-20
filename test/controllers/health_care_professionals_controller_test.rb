require 'test_helper'

class HealthCareProfessionalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @health_care_professional = health_care_professionals(:one)
  end

  test "should get index" do
    get health_care_professionals_url
    assert_response :success
  end

  test "should get new" do
    get new_health_care_professional_url
    assert_response :success
  end

  test "should create health_care_professional" do
    assert_difference('HealthCareProfessional.count') do
      post health_care_professionals_url, params: { health_care_professional: { consultation_fee: @health_care_professional.consultation_fee, email: @health_care_professional.email, name: @health_care_professional.name, resigned_at: @health_care_professional.resigned_at, specialty_id: @health_care_professional.specialty_id } }
    end

    assert_redirected_to health_care_professional_url(HealthCareProfessional.last)
  end

  test "should show health_care_professional" do
    get health_care_professional_url(@health_care_professional)
    assert_response :success
  end

  test "should get edit" do
    get edit_health_care_professional_url(@health_care_professional)
    assert_response :success
  end

  test "should update health_care_professional" do
    patch health_care_professional_url(@health_care_professional), params: { health_care_professional: { consultation_fee: @health_care_professional.consultation_fee, email: @health_care_professional.email, name: @health_care_professional.name, resigned_at: @health_care_professional.resigned_at, specialty_id: @health_care_professional.specialty_id } }
    assert_redirected_to health_care_professional_url(@health_care_professional)
  end

  test "should destroy health_care_professional" do
    assert_difference('HealthCareProfessional.count', -1) do
      delete health_care_professional_url(@health_care_professional)
    end

    assert_redirected_to health_care_professionals_url
  end
end
