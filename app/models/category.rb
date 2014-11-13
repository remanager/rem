class Category < ActiveRecord::Base
  include ApplicationHelper

  validates_presence_of :name
  after_create -> { update_attribute(:permalink, get_permalink(:id, :name)) }
  has_many :properties_categories, class_name: 'PropertiesCategories'
  has_many :properties, through: :properties_categories

  def to_s
    name
  end
end
