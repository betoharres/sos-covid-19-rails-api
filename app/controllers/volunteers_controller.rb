class VolunteersController < ApplicationController
  before_action :authenticate, except: :create
  before_action :set_volunteer, only: %i[show update destroy]

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
    @volunteer.phone = Phone.find_or_create_by(number: volunteer_params[:phone])

    if @volunteer.save
      render json: @volunteer,
             methods: %i[phone_number is_sms_sent phone_is_verified],
             except: :password_digest,
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

  # Only allow a trusted parameter "white list" through.
  def volunteer_params
    params.require(:volunteer).permit(
      :name, :email, :identifier, :identifier_type, :phone, :password
    )
  end
end
