class Patient < ApplicationRecord
  belongs_to :phone, inverse_of: :patients
  scope :with_valid_phones, -> { eager_load(:phone).merge(Phone.validated) }
  reverse_geocoded_by :latitude, :longitude
  delegate :number, to: :phone, prefix: true
  has_paper_trail

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
end
