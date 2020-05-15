class Volunteer < ApplicationRecord
  belongs_to :phone, inverse_of: :volunteers
  attr_accessor :auth_token
  has_secure_token
  has_secure_token :password_reset_token
  has_secure_password

  scope :approved, -> { where(is_approved: true) }

  validates :email, presence: true, uniqueness: true
  delegate :number, to: :phone, prefix: true
  delegate :is_verified, to: :phone, prefix: true
  delegate :is_sms_sent, to: :phone
  scope :with_valid_phone, -> { joins(:phone).merge(Phone.validated) }
end
