module Permissions
  def self.permission_for(user)
    if user.nil?
      GuestPermission.new
    elsif user.role == :admin
      AdminPermission.new(user)
    elsif user.role == :agent
      AgentPermission.new(user)
    else
      OwnerPermission.new(user)
    end
  end
end
