class Admin::DashboardController < AdminController
  def index
    return redirect_to edit_admin_realestate_path(id: current_realestate) if current_realestate.try(:unpublished)
    @pending_users = User.pending
  end

  private
  def current_resource
    nil
  end
end
