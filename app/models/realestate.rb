class Realestate < ActiveRecord::Base
  belongs_to :user
  alias_attribute :agent, :user

  validates_presence_of :name
end
