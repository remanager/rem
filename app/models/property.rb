class Property < ActiveRecord::Base
  belongs_to :town
  belongs_to :user
  belongs_to :category
  belongs_to :detail
  alias_attribute :owner, :user

  validates_presence_of :ref, :town, :user
end
