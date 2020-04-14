class Volunteer < ApplicationRecord
  belongs_to :phone, inverse_of: :volunteer
  validates :email, presence: true, uniqueness: true
end
