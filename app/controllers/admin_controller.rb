class AdminController < ApplicationController
  # Authentication
  before_filter :authenticate_user!
  # Authorization
  before_filter :authorize_action?
  before_filter -> { @active = { request[:controller] => true } }
  delegate :allow?, to: :current_permission
  delegate :allow_param?, to: :current_permission
  helper_method :allow?, :allow_param?, :current_realestate

  layout 'admin'

  private
  def current_realestate
    current_user.realestate
  end

  def authenticate_user!
    redirect_to login_path, alert: 'You must log in!' if !current_user
  end

  def authorize_action?
    if current_permission.allow?(params[:controller], params[:action], current_resource)
      current_permission.permit_params! params
    elsif current_user.nil?
      redirect_to login_path, alert: 'You must log in!'
    else
      redirect_to admin_dashboard_path, alert: 'Not authorized.'
    end
  end

  def current_permission
    @current_permission ||= ::Permissions.permission_for(current_user)
  end
end
