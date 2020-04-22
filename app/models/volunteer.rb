class Volunteer < ApplicationRecord
  belongs_to :phone, inverse_of: :volunteer
  validates :email, presence: true, uniqueness: true
  delegate :number, to: :phone, prefix: true
  delegate :is_verified, to: :phone, prefix: true
  delegate :is_sms_sent, to: :phone
end
