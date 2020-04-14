class Phone < ApplicationRecord
  scope :validated, -> { where(is_verified: true) }

  has_many :patients, dependent: :delete_all, inverse_of: :phone
  has_one :volunteer, dependent: :destroy, inverse_of: :phone

  validates :number, presence: true, uniqueness: true

  # TODO: send sms also after
  before_create :send_sms_code

  private

  def send_sms_code
    generated_code = rand(0o000..9999).to_s.rjust(4, '0')
    self.verification_code = generated_code
    TwilioClient.new.send_text(
      number,
      "SOS COVID-19 - Seu código: #{generated_code}"
    )
  end
end
