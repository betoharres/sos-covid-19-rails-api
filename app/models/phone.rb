class Phone < ApplicationRecord
  attr_accessor :is_sms_sent
  scope :validated, -> { where(is_verified: true) }

  has_many :patients, dependent: :delete_all, inverse_of: :phone
  has_one :volunteer, dependent: :destroy, inverse_of: :phone

  validates :number, presence: true, uniqueness: true

  private

  def code_valid?(user_sms_code)
    user_sms_code == sms_code
  end

  def generate_new_sms_code!
    generated_code = rand(0o000..9999).to_s.rjust(4, '0')
    update!(sms_code: generated_code)
    generated_code
  end

  def send_sms_code!
    self.is_sms_sent = true
    generate_new_sms_code!
    TwilioClient.new.send_text(
      number,
      "SOS COVID-19 - Seu código: #{generated_code}"
    )
  end
end
