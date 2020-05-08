class Patient < ApplicationRecord
  attr_accessor :auth_token
  belongs_to :phone, inverse_of: :patients
  delegate :number, to: :phone, prefix: true
  delegate :is_verified, to: :phone, prefix: true
  delegate :is_sms_sent, to: :phone
  reverse_geocoded_by :latitude, :longitude
  has_paper_trail

  scope :with_valid_phone, -> { eager_load(:phone).merge(Phone.validated) }

  after_create :check_phone

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

  def check_phone
    phone.send_sms_code unless phone.is_verified
  end
end
