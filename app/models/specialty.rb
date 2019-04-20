class Specialty < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false

  has_many :health_care_professionals
end
