class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if user
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to root_path, notice: 'Logged in!'
    else
      flash[:alert] = 'Invalid email or password.'
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_path, notice: 'Logged out!'
  end
end
