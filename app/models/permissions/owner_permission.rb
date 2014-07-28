module Permissions
  class OwnerPermission < BasePermission
    def initialize(user)
      allow :sessions, [:new]
    end
  end
end
