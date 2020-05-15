class Phone < ApplicationRecord
  attr_accessor :is_sms_sent
  has_secure_token
  scope :validated, -> { where(is_verified: true) }

  has_many :patients, dependent: :delete_all, inverse_of: :phone
  has_many :volunteers, dependent: :delete_all, inverse_of: :phones

  validates :number, presence: true, uniqueness: true

  after_create :send_sms_code, :destroy_unverified_phone

  def sms_code_valid?(user_sms_code)
    update!(is_verified: true) if user_sms_code == sms_code
  end

  def resend_sms_code
    return if DateTime.now.to_i - updated_at.to_i < 120 # seconds

    send_sms_code
  end

  def send_sms_code
    code = generate_new_sms_code
    TwilioClient.new.send_text(
      number,
      "Ajuda Coronavirus - Codigo SMS: #{code}"
    )
    self.is_sms_sent = true
  end

  private

  def generate_new_sms_code
    generated_code = rand(0..9999).to_s.rjust(4, '0')
    update!(sms_code: generated_code)
    generated_code
  end

  def destroy_unverified_phone
    PhoneCleanupJob.set(wait: 30.minutes).perform_later id
  end
end
