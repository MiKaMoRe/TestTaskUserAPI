# frozen_string_literal: true

class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authorize_request!, only: [:create]

  before_action :configure_sign_up_params, only: [:create]

  respond_to :json
  # before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    super
  end

  protected

  def respond_with(current_user, _opts = {})
    return render_success(current_user.serialize, message: 'Signed up successfully.') if resource.persisted?

    render_unprocessable_entity(current_user)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password first_name last_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
