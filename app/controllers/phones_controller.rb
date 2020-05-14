class PhonesController < ApplicationController
  # before_action :set_phone, only: %i[show update destroy]

  # POST /phones/validate
  def validate
    @phone = Phone.find_by(number: phone_params[:number])
    if @phone&.sms_code_valid?(phone_params[:sms_code])
      @phone.regenerate_token
      render json: { success: true, token: @phone.token }
    elsif @phone
      render json: { error: 'Invalid code' }
    else
      render json: { error: 'Phone not found' }
    end
  end

  # POST /phone/resend_sms_code
  def resend_sms_code
    @phone = Phone.find_by(number: phone_params[:number])

    if @phone.nil?
      return render json: { error: 'Phone not found' }, status: :not_found
    end

    if @phone.resend_sms_code
      render json: { success: true }
    else
      render json: { error: 'Too early' }, status: :not_acceptable
    end
  end

  # # GET /phones
  # def index
  #   @phones = Phone.all
  #
  #   render json: @phones
  # end
  #
  # # GET /phones/1
  # def show
  #   render json: @phone
  # end

  # POST /phones
  def create
    @phone = Phone.new(number: phone_params[:number])

    if @phone.save
      render json: @phone, methods: :is_sms_sent, status: :created
    else
      render json: @phone.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /phones/1
  # def update
  #   if @phone.update(phone_params)
  #     render json: @phone
  #   else
  #     render json: @phone.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # DELETE /phones/1
  # def destroy
  #   @phone.destroy
  # end
  #
  # private
  #
  # # Use callbacks to share common setup or constraints between actions.
  # def set_phone
  #   @phone = Phone.find(params[:id])
  # end
  #
  # Only allow a trusted parameter "white list" through.
  def phone_params
    params.require(:phone).permit(:number, :sms_code)
  end
end
