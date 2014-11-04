class PropertiesCategories < ActiveRecord::Base
  belongs_to :property
  belongs_to :category
end
