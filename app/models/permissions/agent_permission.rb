module Permissions
  class AgentPermission < BasePermission
    def initialize(user)
      all_actions = [:index, :new, :create, :show, :edit, :update, :destroy]

      allow :'admin/dashboard', [:index]
      allow :'admin/users', [:index, :new, :create]
      allow :'admin/users', [:edit, :update, :destroy] do |current_resource|
        user == current_resource || user.my_users.include?(current_resource)
      end
      allow :'admin/realestates', [:show, :edit, :update, :publish, :unpublish] do |current_resource|
        user.realestate == current_resource
      end
      allow :'admin/properties', [:index, :new, :create]
      allow :'admin/properties', [:show, :edit, :update, :destroy] do |current_resource|
        user.realestate == current_resource.realestate
      end
      allow :'admin/details', all_actions
      allow :'admin/categories', all_actions
    end
  end
end
