class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def authenticate
    authenticate_or_request_with_http_token do |token|
      Volunteer.approved.with_valid_phone.find_by(token: token)
    end
  end

  def current_user
    @current_user ||= authenticate
  end

  def current_token
    @current_user&.token
  end
end
