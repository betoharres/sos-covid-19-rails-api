class Patient < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude
  include AASM

  aasm do
    state :waiting, initial: true
    state :testing
    state :infected
    state :discarded

    event :call do
      transitions from: :waiting, to: %i[testing discard]
    end

    event :discard do
      transitions from: %i[waiting testing], to: :discard
    end

    event :test_positive do
      transitions from: :testing, to: :infected
    end
  end

  belongs_to :phone
end
