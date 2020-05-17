class SessionController < ApplicationController
  def new
    @volunteer = Volunteer
                 .approved
                 .find_by(email: params[:email])
                 .try(:authenticate, params[:password])
    if @volunteer
      @volunteer.regenerate_token
      @volunteer.auth_token = @volunteer.token
      render json: @volunteer,
             methods: :auth_token,
             except: %i[password_digest password_reset_token]
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
