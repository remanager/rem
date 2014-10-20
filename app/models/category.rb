class Category < ActiveRecord::Base
  validates_presence_of :name
  has_many :properties_categories, class_name: 'PropertiesCategories'
  has_many :properties, through: :properties_categories

  def to_s
    name
  end
end
