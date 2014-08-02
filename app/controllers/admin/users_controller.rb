class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = current_user.my_users
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.set_default_role(current_user.role) unless current_user.admin?

    if user.save
      redirect_to admin_users_path, notice: 'New user created!'
    else
      flash[:alert] = 'Some errors happened.'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User updated!'
    else
      flash[:alert] = 'Error updating.'
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'User deleted!'
    else
      redirect_to admin_users_path, alert: 'Error deleting.'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def current_resource
    @current_resource ||= current_user
  end
end
