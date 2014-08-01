class User < ActiveRecord::Base
  has_one :realestate
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  has_secure_password
  before_create { generate_token(:auth_token) }

  def set_default_role(current_role)
    if current_role
      if current_role == :admin
        self.role = ROLES.index :agent
      elsif current_role == :agent
        self.role = ROLES.index :owner
      end
    end
  end

  def admin?
    self.role == :admin
  end

  def role
    ROLES[self.attributes['role']] if self.attributes['role']
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
