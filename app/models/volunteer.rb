class Volunteer < ApplicationRecord
  belongs_to :phone, inverse_of: :volunteer
  validates :email, presence: true, uniqueness: true
  delegate :number, to: :phone, prefix: true
  delegate :is_verified, to: :phone, prefix: true
  delegate :is_sms_sent, to: :phone

  after_commit :track_unverified_phone_record

  def track_unverified_phone_record
    PhoneCleanupJob.set(wait: 30.minutes).perform_later phone.id
  end
end
