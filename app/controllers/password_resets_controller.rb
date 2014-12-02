class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to login_path, notice: 'Email sent with password reset instructions.'
    else
      flash[:alert] = 'Email not registered.'
      render :new
    end
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])
    redirect_to login_path, alert: 'Invalid token.' if !@user
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_resets_path, alert: 'Password reset has expired.'
    elsif @user.update_attributes(user_params)
      redirect_to login_path, notice: 'Password has been changed!'
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
