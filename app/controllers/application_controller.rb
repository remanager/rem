class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_realestate
  before_filter :set_locale

  def default_url_options
    {
      locale: I18n.locale
    }
  end

  private
  def current_user
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end

  def current_realestate
    Realestate.find(params[:realestate_id])
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end
end
