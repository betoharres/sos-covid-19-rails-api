class Patient < ApplicationRecord
  attr_accessor :auth_token
  belongs_to :phone, inverse_of: :patients
  delegate :number, to: :phone, prefix: true
  delegate :is_verified, to: :phone, prefix: true
  delegate :is_sms_sent, to: :phone
  reverse_geocoded_by :latitude, :longitude
  has_paper_trail

  scope :with_valid_phone, -> { eager_load(:phone).merge(Phone.validated) }

  include AASM
  aasm do
    state :waiting, initial: true
    state :testing
    state :visiting
    state :observing
    state :infected
    state :discarded

    # patient and will be visited by the volunteer
    event :call do
      transitions from: :waiting, to: %i[waiting discard]
    end

    # patient and will be visited by the volunteer
    event :visit do
      transitions from: %i[waiting testing observing], to: :visiting
    end

    # patient is in observation
    event :observe do
      transitions from: %i[waiting testing observing], to: :observing
    end

    # pacient test negative to covid-19, invalid symptoms, cured, etc...
    event :discard do
      transitions from: %i[waiting testing visiting], to: :discard
    end

    # pacient tested positive to covid-19
    event :infect do
      transitions from: %i[waiting testing visiting], to: :infected
    end
  end
end
