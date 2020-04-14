class PatientsController < ApplicationController
  # before_action :authenticate, except: :index, :create
  before_action :set_patient, only: %i[show update destroy]

  # GET /patients
  def index
    coordinates = [params[:latitude], params[:longitude]]
    range = params[:map_zoom] || 20
    @patients = Patient.with_valid_phones.near(coordinates, range)

    # if @current_user
    render json: @patients, methods: :phone_number
    # else
    # render json: @patients
    # end
  end

  # GET /patients/1
  def show
    render json: @patient
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params.except(:phone))
    @patient.phone = Phone.find_or_create_by(number: patient_params[:phone])

    if @patient.save
      render json: @patient, status: :created, location: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
  end

  def authenticate
    authenticate_or_request_with_http_token do |token|
      Volunteer.find_by(token: token)
    end
  end

  def current_user
    @current_user ||= authenticate
  end

  # Only allow a trusted parameter "white list" through.
  def patient_params
    params.require(:patient).permit(
      :phone,        :latitude,          :longitude,         :name,
      :age,          :weight,            :fever,             :tired,
      :headache,     :cough,             :short_breath,      :diarrhea,
      :hyposmia,     :hypogeusia,        :map_zoom
    )
  end
end
