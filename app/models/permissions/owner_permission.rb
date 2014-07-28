module Permissions
  class OwnerPermission < BasePermission
    def initialize(user)
      allow :'admin/properties', [:show] do
        current_user.id == current_resource.user_id
      end
    end
  end
end
