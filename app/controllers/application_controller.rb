class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def authenticate
    authenticate_or_request_with_http_token do |token|
      volunteer = Volunteer.find_by(token: token)
      return volunteer if volunteer&.phone&.is_verified?
    end
  end

  def current_user
    @current_user ||= authenticate
  end

  def current_token
    @current_user&.token
  end
end
