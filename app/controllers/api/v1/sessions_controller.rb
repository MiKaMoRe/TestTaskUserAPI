# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :authorize_request!, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def respond_with(current_user, _opts = {})
    render json: {
      status: {
        code: 200, message: 'Logged in successfully.',
        data: current_user.serializable_hash(only: %i[email first_name last_name])
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    @user ||= current_user(request)
    
    render json: {
      status: 200,
      message: 'Logged out successfully.'
    }, status: :ok
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
