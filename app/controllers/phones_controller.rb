class PhonesController < ApplicationController
  # before_action :set_phone, only: %i[show update destroy]

  # POST /phones/validate
  def validate
    @phone = Phone.find_by(number: phone_params[:number])
    if @phone
      is_phone_valid = @phone.sms_code == phone_params[:sms_code]
      if is_phone_valid
        @phone.update!(is_verified: true)
        render json: { success: is_phone_valid }
      else
        render json: { error: 'Invalid code' }
      end
    else
      render json: { error: 'Phone not found' }
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
  #
  # # POST /phones
  # def create
  #   @phone = Phone.find_or_create_by(number: phone_params[:number])
  #
  #   if @phone.save
  #     render json: @phone, status: :created, location: @phone
  #   else
  #     render json: @phone.errors, status: :unprocessable_entity
  #   end
  # end
  #
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
