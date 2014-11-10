class Realestate < ActiveRecord::Base
  belongs_to :user
  has_many :pictures
  has_many :properties
  alias_attribute :agent, :user

  validates_presence_of :name

  def to_s
    name
  end
end
