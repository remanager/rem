class User < ActiveRecord::Base
  has_one :realestate
  has_many :properties
  validates_confirmation_of :password, on: :create
  validates_presence_of :password, on: :create
  validates_presence_of :email, :name, :surname, :address
  validates_uniqueness_of :email
  validates_format_of :email, with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  has_secure_password
  before_create { generate_token(:auth_token) }

  scope :same_realestate, ->(id) { User.joins(properties: :realestate).where('realestates.id = ?', id).distinct }
  scope :pending, -> { where(status: STATUS_PENDING) }
  scope :valid, -> { where(status: STATUS_OK) }

  ROLES = %w(owner agent admin)
  STATUS_BANNED = -1
  STATUS_PENDING = 0
  STATUS_OK = 1

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
    admin? ? User.all : User.same_realestate(realestate.id)
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

  def name_complete
    "#{ name } #{ surname }"
  end

  def role?(base_role)
    return false unless role
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def admin?
    self.role.to_sym == :admin
  end

  def agent?
    self.role.to_sym == :agent
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
