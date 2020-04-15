class Volunteer < ApplicationRecord
  belongs_to :phone, inverse_of: :volunteer
  validates :email, presence: true, uniqueness: true
  delegate :number, to: :phone, prefix: true
  delegate :is_new_phone_record, to: :phone
end
