class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: %i[update show destroy]

  respond_to :json
  
  def index
    render_success({ users: User.all.map(&:serialize) })
  end

  def show
    render_success(@user.serialize)
  end

  def update
    return render_forbidden unless can_manage?(@user)
    return render_success(@user.serialize) if @user.update(user_params)

    render_unprocessable_entity(@user)
  end

  def destroy
    return render_success(@user.serialize) if can_manage?(@user) && @user.destroy

    render_unprocessable_entity(@user)
  end

  private

  def can_manage?(user)
    @current_user.id == user.id
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end