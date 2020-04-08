class Patient < ApplicationRecord
  has_paper_trail
  scope :with_valid_phones, -> { eager_load(:phone).merge(Phone.validated) }
  reverse_geocoded_by :latitude, :longitude
  include AASM

  aasm do
    state :waiting, initial: true
    state :testing
    state :visiting
    state :infected
    state :discarded

    event :call do
      transitions from: :waiting, to: %i[testing discard]
    end

    event :visit do
      transitions from: :waiting, to: :visiting
    end

    event :discard do
      transitions from: %i[waiting testing visiting], to: :discard
    end

    event :infect do
      transitions from: %i[waiting testing visiting], to: :infected
    end
  end

  belongs_to :phone
end
