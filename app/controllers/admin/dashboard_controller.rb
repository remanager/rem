class Admin::DashboardController < AdminController
  def index
    render "index_#{current_user.role}"
  end

  private
  def current_resource
    nil
  end
end
