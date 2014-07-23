module Permissions
  class AgentPermission < BasePermission
    def initialize(user)
      allow :'admin/users', [:new, :create]
    end
  end
end
