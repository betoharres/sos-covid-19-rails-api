class Patient < ApplicationRecord
  belongs_to :phone, inverse_of: :patients
  delegate :number, to: :phone, prefix: true
  delegate :is_verified, to: :phone, prefix: true
  delegate :is_sms_sent, to: :phone
  reverse_geocoded_by :latitude, :longitude
  has_paper_trail

  scope :with_valid_phones, -> { eager_load(:phone).merge(Phone.validated) }

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
