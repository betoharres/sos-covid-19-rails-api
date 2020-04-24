class SessionController < ApplicationController
  def new
    @volunteer = Volunteer
                 .find_by(email: params[:email])
                 .try(:authenticate, params[:password])
    if @volunteer
      headers['access_token'] = @volunteer.token
      headers['token_type'] = 'Bearer'
      @volunteer.regenerate_token
      headers['refresh_token'] = @volunteer.token
      headers['expires_in'] = 30 * 60
      render json: @volunteer
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
