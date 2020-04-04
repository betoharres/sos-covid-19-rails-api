class TwilioClient
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def send_text(destination_number, message)
    client.messages.create(
      to: destination_number,
      from: twilio_number,
      body: message
    )
  end

  def account_sid
    Rails.application.credentials.twilio[:account_sid]
  end

  def auth_token
    Rails.application.credentials.twilio[:auth_token]
  end

  def twilio_number
    Rails.application.credentials.twilio[:phone_number]
  end
end
