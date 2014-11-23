class User < ActiveRecord::Base
  has_one :realestate
  validates_confirmation_of :password, on: :create
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  has_secure_password
  before_create { generate_token(:auth_token) }

  scope :same_realestate, ->(id) { User.joins(realestate: :properties).where('realestates.id = ?', id).distinct }

  ROLES = %w(owner agent admin)

  def set_default_role(current_role)
    if current_role
      if current_role == :admin
        self.role = :agent
      elsif current_role == :agent
        self.role = :owner
      end
    end
  end

  def self.possible_roles(user_role)
    ROLES.select { |role| ROLES.index(role) <= ROLES.index(user_role)  }
  end

  def my_users
    return User.all if admin?
    User.same_realestate(self.realestate.id)
  end

  def my_properties
    if admin?
      Property.all
    elsif role.to_sym == :agent
      Property.same_realestate(realestate.id)
    else
      Property.same_owner(id)
    end
  end

  def admin?
    self.role == :admin
  end

  def role?(base_role)
    return false unless role
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def admin?
    self.role.to_sym == :admin
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def to_s
    email
  end
end
