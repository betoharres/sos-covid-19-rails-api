class Phone < ApplicationRecord
  has_many :patients, dependent: :delete_all
  has_one :volunteer, dependent: :destroy

  before_validation :send_sms_code

  private

  def send_sms_code
    generated_code = rand(0o000..9999).to_s.rjust(4, '0')
    self.verification_code = generated_code
    TwilioClient.new.send_text(number, "SOS COVID-19 - Seu código: #{generated_code}")
  end
end
