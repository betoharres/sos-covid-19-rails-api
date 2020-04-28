class PatientStateController < ApplicationController
  before_action %i[authenticate set_patient]
  before_action :set_paper_trail_whodunnit, except: :history

  # POST /call/:id
  def call
    @patient.call!
    render json: @patient, methods: :auth_token
  end

  # POST /visit/:id
  def visit
    @patient.visit!
    render json: @patient, methods: :auth_token
  end

  # POST /discard/:id
  def discard
    @patient.discard!
    render json: @patient, methods: :auth_token
  end

  # POST /infect/:id
  def infect
    @patient.infect!
    render json: @patient, methods: :auth_token
  end

  def history
    render json: @patient.versions, methods: :auth_token
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:patient_id])
    @patient.auth_token = current_token
  end

  # Only allow a trusted parameter "white list" through.
  def patient_params
    params.require(:patient_state).permit(:patient_id)
  end
end
