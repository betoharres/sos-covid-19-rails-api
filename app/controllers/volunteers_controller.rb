class VolunteersController < ApplicationController
  before_action :authenticate, except: :create
  before_action :set_volunteer, only: %i[show update destroy]
  before_action :set_phone, only: :create

  # # GET /volunteers
  # def index
  #   @volunteers = Volunteer.all
  #   add `except: :password_digest` before uncomment this
  #   render json: @volunteers
  # end

  # GET /volunteers/1
  def show
    render json: @volunteer, except: :password_digest, methods: :auth_token
  end

  # POST /volunteers
  def create
    @volunteer = Volunteer.new(volunteer_params.except(:phone))
    @volunteer.phone = @phone.errors.any? ? nil : @phone

    if @volunteer.save
      @volunteer.auth_token = @volunteer.token
      render json: @volunteer,
             methods: %i[phone_number is_sms_sent phone_is_verified],
             except: %i[password_digest token auth_token],
             status: :created,
             location: @volunteer
    else
      render json: @volunteer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /volunteers/1
  def update
    if @volunteer.update(volunteer_params)
      render json: @volunteer, except: :password_digest, methods: :auth_token
    else
      render json: @volunteer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /volunteers/1
  def destroy
    @volunteer.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
    @volunteer.auth_token = current_token
  end

  def set_phone
    if volunteer_params[:phone_token]
      @phone = Phone.find_by(token: volunteer_params[:phone_token])
      @phone.send_sms_code unless @phone&.is_verified
    else
      @phone = Phone.create(number: volunteer_params[:phone])
    end
  end

  # Only allow a trusted parameter "white list" through.
  def volunteer_params
    params.require(:volunteer).permit(
      :name,        :email,      :identifier,  :identifier_type, :phone,
      :website,     :password,   :phone_token, :job_desire,      :job_experience
    )
  end
end
