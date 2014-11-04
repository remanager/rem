module Permissions
  class OwnerPermission < BasePermission
    def initialize(user)
      allow :'admin/dashboard', [:index]
      allow :'admin/properties', [:index]
      allow :'admin/properties', [:show] do |current_resource|
        user.id == current_resource.user_id
      end
    end
  end
end
