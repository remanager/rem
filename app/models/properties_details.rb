class PropertiesDetails < ActiveRecord::Base
  belongs_to :property
  belongs_to :detail
end
