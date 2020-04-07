class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  # GET /patients
  def index
    @patients = Patient.near(
      [patient_params[:latitude], patient_params[:longitude]],
      patient_params[:map_zoom] || 10
    )

    render json: @patients
  end

  # GET /patients/1
  def show
    render json: @patient
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params)
    @patient.phone = Phone.find_or_create_by(phone: patient_params[:phone])

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
