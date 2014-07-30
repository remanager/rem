class Admin::DashboardController < AdminController
  def index
    unless current_user.admin?
      return
    end
  end

  private
  def current_resource
    nil
  end
end
