class Volunteer < ApplicationRecord
  has_secure_token
  has_secure_token :password_reset_token
  has_secure_password

  belongs_to :phone, inverse_of: :volunteer
  validates :email, presence: true, uniqueness: true
  delegate :number, to: :phone, prefix: true
  delegate :is_verified, to: :phone, prefix: true
  delegate :is_sms_sent, to: :phone
end
