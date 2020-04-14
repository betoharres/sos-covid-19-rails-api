class PatientStateController < ApplicationController
  before_action :set_paper_trail_whodunnit, except: :history
  before_action :set_patient, :authenticate

  # POST /call/:id
  def call
    @patient.call!
  end

  # POST /visit/:id
  def visit
    @patient.visit!
  end

  # POST /discard/:id
  def discard
    @patient.discard!
  end

  # POST /infect/:id
  def infect
    @patient.infect!
  end

  def history
    render json: @patient.versions
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
  end

  def authenticate
    authenticate_or_request_with_http_token do |token|
      @volunteer = Volunteer.find_by(token: token)
    end
  end

  def current_user
    @current_user ||= authenticate
  end

  # Only allow a trusted parameter "white list" through.
  def patient_params
    params.require(:patient_state).permit(:volunteer_id)
  end
end
