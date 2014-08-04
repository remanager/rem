module Permissions
  def self.permission_for(user)
    if user.nil?
      GuestPermission.new
    elsif user.role.to_sym == :admin
      AdminPermission.new(user)
    elsif user.role.to_sym == :agent
      AgentPermission.new(user)
    else
      OwnerPermission.new(user)
    end
  end
end
