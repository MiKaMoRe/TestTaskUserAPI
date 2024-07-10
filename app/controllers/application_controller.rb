class ApplicationController < ActionController::API
  before_action :authorize_request!

  respond_to :json

  protected

  def render_forbidden
    render json: { status: 403 }, status: :forbidden
  end

  def render_success(data, **options)
    render json: {
      status: 200,
      data: data
    }.merge(options), status: :ok
  end

  def render_unprocessable_entity(entity)
    render json: {
        status: { code: 422, message: entity.errors.full_messages.to_sentence }
      }, status: :unprocessable_entity
  end

  def current_user(request)
    return nil unless request.headers['Authorization']

    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
    User.find(jwt_payload['sub'])
  end

  def authorize_request!
    @current_user = current_user(request)

    unless @current_user
      render json: {
        status: 401,
        message: 'Unauthorized'
      }, status: :unauthorized
    end
  end
end
