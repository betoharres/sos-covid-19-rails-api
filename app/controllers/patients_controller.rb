class PatientsController < ApplicationController
  before_action :authenticate, except: %i[guest create]
  before_action :set_patient, only: %i[show update destroy]

  # GET /patients
  def index
    coordinates = [params[:latitude], params[:longitude]]
    @patients = Patient.with_valid_phone.near(coordinates, 20)

    render json: @patients, methods: :phone_number
  end

  def guest
    coordinates = [params[:latitude], params[:longitude]]
    @patients = Patient.with_valid_phone.near(coordinates, 20)

    render json: @patients, except: :phone_number
  end

  # GET /patients/1
  def show
    render json: @patient, methods: :auth_token
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params.except(:phone))
    @phone = Phone.find_by(number: patient_params[:phone])

    if @phone
      @phone.send_sms_code unless @phone.is_verified
    else
      @phone = Phone.create(number: patient_params[:phone])
    end

    @patient.phone = @phone

    if @patient.save
      render json: @patient,
             methods: %i[phone_number is_sms_sent phone_is_verified],
             status: :created,
             location: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      render json: @patient, methods: :auth_token
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy
    render json: { auth_token: current_token }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
    @patient.auth_token = current_token
  end

  # Only allow a trusted parameter "white list" through.
  def patient_params
    params.require(:patient).permit(
      :phone,        :latitude,          :longitude,         :name,
      :age,          :weight,            :fever,             :tired,
      :headache,     :cough,             :short_breath,      :diarrhea,
      :hyposmia,     :hypogeusia,        :description
    )
  end
end
