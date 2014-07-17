class UsersController < ApplicationController
  before_filter :authorize

  def new
    @user = User.new
    if current_user.role == ROLES[:admin]
      render :admin_new
    else
      @user.role = ROLES[:owner]
      render :agent_new
    end
  end

  def create
    user = User.new(user_params)
    user.set_default_role unless current_user.admin?

    if user.save
      redirect_to root_path, notice: 'New agent created!'
    else
      flash[:alert] = 'Some errors happened.'
      render :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def authorize
    auth_roles = [ROLES[:admin], ROLES[:agent]]
    redirect_to root_path, alert: 'Not allowed.' unless auth_roles.include? current_user.role
  end

end
