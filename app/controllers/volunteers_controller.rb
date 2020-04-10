class VolunteersController < ApplicationController
  # before_action :authenticate
  before_action :set_volunteer, only: %i[show update destroy]

  # GET /volunteers
  def index
    @volunteers = Volunteer.all

    render json: @volunteers
  end

  # GET /volunteers/1
  def show
    render json: @volunteer
  end

  # POST /volunteers
  def create
    @volunteer = Volunteer.new(volunteer_params)
    @volunteer.phone = Phone.find_or_create_by(number: volunteer_params[:phone])

    if @volunteer.save
      render json: @volunteer, status: :created, location: @volunteer
    else
      render json: @volunteer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /volunteers/1
  def update
    if @volunteer.update(volunteer_params)
      render json: @volunteer
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
  end

  # Only allow a trusted parameter "white list" through.
  def volunteer_params
    params.require(:volunteer).permit(
      :name, :identifier, :identifier_type, :phone
    )
  end

  def authenticate
    authenticate_or_request_with_http_token do |token|
      Volunteer.find_by(token: token)
    end
  end

  def current_user
    @current_user ||= authenticate
  end
end
