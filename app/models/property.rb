class Property < ActiveRecord::Base
  belongs_to :town
  belongs_to :user
  belongs_to :realestate
  has_many :properties_categories, class_name: 'PropertiesCategories'
  has_many :categories, through: :properties_categories
  has_many :properties_details, class_name: 'PropertiesDetails'
  has_many :details, through: :properties_details

  alias_attribute :owner, :user

  validates_presence_of :ref, :town

  def self.properties_for(user)
    if user.admin?
      all
    elsif user.role.to_sym == :agent
      user.realestate.properties
    else
      user.properties
    end
  end

  def to_s
    ref
  end
end
