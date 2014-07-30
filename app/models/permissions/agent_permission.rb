module Permissions
  class AgentPermission < BasePermission
    def initialize(user)
      all_actions = [:new, :create, :show, :edit, :update, :destroy]

      allow :'admin/dashboard', [:index]
      allow :'admin/users', [:new, :create]
      allow :'admin/realestates', [:show, :edit, :update] do
        current_user.id == current_resource.agent_id
      end
      allow :'admin/properties', all_actions do
        current_user.realestate_id == current_resource.realestate_id
      end
      allow :'admin/details', all_actions
      allow :'admin/categories', all_actions
    end
  end
end
