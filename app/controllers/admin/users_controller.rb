class Admin::UsersController < AdminController
  before_action :set_user, only: [:edit, :update, :destroy, :approve, :ban]

  def index
    @users = current_user.my_users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.set_default_role(current_user.role) unless current_user.admin?

    return redirect_to admin_users_path, notice: 'New user created!' if @user.save

    flash[:alert] = 'Some errors happened.'
    render :new
  end

  def edit
  end

  def update
    return redirect_to admin_users_path, notice: 'User updated!' if @user.update(user_params)

    flash[:alert] = 'Error updating.'
    render :edit
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'User deleted!'
    else
      redirect_to admin_users_path, alert: 'Error deleting.'
    end
  end

  def approve
    @user.update_attribute(:status, User::STATUS_OK)
    @user.create_realestate(name: "#{ @user.name }'s Realestate", email: @user.email, address: @user.address)
    UserMailer.approved(@user).deliver
    redirect_to edit_admin_user_path(id: @user)
  end

  def ban
    @user.update_attribute(status: User::STATUS_BANNED, auth_token: nil)
    redirect_to edit_admin_user_path(id: @user)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :name, :surname, :address)
  end

  def current_resource
    @current_resource ||= current_user
  end
end
