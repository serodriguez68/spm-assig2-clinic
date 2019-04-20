require "application_system_test_case"

class HealthCareProfessionalsTest < ApplicationSystemTestCase
  setup do
    @health_care_professional = health_care_professionals(:one)
  end

  test "visiting the index" do
    visit health_care_professionals_url
    assert_selector "h1", text: "Health Care Professionals"
  end

  test "creating a Health care professional" do
    visit health_care_professionals_url
    click_on "New Health Care Professional"

    fill_in "Consultation fee", with: @health_care_professional.consultation_fee
    fill_in "Email", with: @health_care_professional.email
    fill_in "Name", with: @health_care_professional.name
    fill_in "Resigned at", with: @health_care_professional.resigned_at
    fill_in "Specialty", with: @health_care_professional.specialty_id
    click_on "Create Health care professional"

    assert_text "Health care professional was successfully created"
    click_on "Back"
  end

  test "updating a Health care professional" do
    visit health_care_professionals_url
    click_on "Edit", match: :first

    fill_in "Consultation fee", with: @health_care_professional.consultation_fee
    fill_in "Email", with: @health_care_professional.email
    fill_in "Name", with: @health_care_professional.name
    fill_in "Resigned at", with: @health_care_professional.resigned_at
    fill_in "Specialty", with: @health_care_professional.specialty_id
    click_on "Update Health care professional"

    assert_text "Health care professional was successfully updated"
    click_on "Back"
  end

  test "destroying a Health care professional" do
    visit health_care_professionals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Health care professional was successfully destroyed"
  end
end
