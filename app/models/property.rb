class Property < ActiveRecord::Base
  belongs_to :town
  belongs_to :user
  belongs_to :category
  belongs_to :detail
end
