class HealthCareProfessional < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :consultation_fee, numericality: { greater_than_or_equal_to: 0, less_than: 1000}

  # Associations
  belongs_to :specialty
  has_many :appointments

  # Delegators
  delegate :name, prefix: true, allow_nil: true, to: :specialty

  def resign!
    update!(resigned_at: Time.now)
  end

  def resigned?
    resigned_at.present?
  end
end
