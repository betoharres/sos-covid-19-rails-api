class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def authenticate
    authenticate_or_request_with_http_token do |token|
      volunteer = Volunteer.find_by(token: token)
      if volunteer&.phone&.is_verified?
        headers['access_token'] = volunteer.token
        headers['token_type'] = 'Bearer'
        if volunteer.updated_at < 30.seconds.ago
          volunteer.regenerate_token
          headers['refresh_token'] = volunteer.token
          headers['expires_in'] = 30 * 60
        end
        volunteer
      end
    end
  end

  def current_user
    @current_user ||= authenticate
  end
end
