class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

    return redirect_to login_path, alert: 'Invalid email or password.' if !user
    return redirect_to login_path, alert: 'You user, is still approval pending.' if user.status == User::STATUS_PENDING

    if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token
    end
    redirect_to admin_dashboard_path, notice: 'Logged in!'
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_path, notice: 'Logged out!'
  end
end
