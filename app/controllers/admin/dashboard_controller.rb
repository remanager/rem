class Admin::DashboardController < AdminController
  def index
    @pending_users = User.pending
  end

  private
  def current_resource
    nil
  end
end
