class Admin::DashboardController < AdminController
  def index
    unless current_user.admin?
      if current_user.role == :agent then render 'agent_index' else render 'owner_index' end
      return
    end
  end

  private
  def current_resource
    nil
  end
end
