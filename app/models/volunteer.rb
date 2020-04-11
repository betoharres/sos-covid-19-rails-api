class Volunteer < ApplicationRecord
  belongs_to :phone, inverse_of: :volunteer
end
