class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.auth_token == BCrypt::Engine.hash_secret(password, user.password_digest)
      user
    end
  end

  def set_default_role
    if current_user.role and current_user.role < ROLES[:owner]
      self.role = current_user.role + 1
    end
  end

  def admin?
    self.role == ROLES[:admin]
  end

  private
  def encrypt_password
    if password.present?
      self.password_digest = BCrypt::Engine.generate_salt
      self.auth_token = BCrypt::Engine.hash_secret(password, password_digest)
    end
  end
end
