class User < ApplicationRecord
  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?

  # Validations
  validates :name, presence: true
  validates :address, presence: true, length: { minimum: 5 }
  validates :phone,presence: true,
            numericality: true,
            length: { minimum: 10, maximum: 15 }

  private

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
