class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

    render 'new', notice: 'Invalid email or password.' unless user
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
