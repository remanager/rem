class User < ActiveRecord::Base
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  has_secure_password

  def set_default_role
    if current_user.role
      if current_user.role == :admin
        self.role = ROLES.key :agent
      elsif current_user.role == :agent
        self.role = ROLES.key :owner
      end
    end
  end

  def admin?
    self.role == :admin
  end

  def role
    ROLES[self.attributes['role']] if self.attributes['role']
  end

 #def role=(role)
 #  self.attributes['role'] = ROLES.index role
 #end
end
