class Realestate < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user
  has_many :properties
  alias_attribute :agent, :user

  validates_presence_of :name
  after_create -> { update_attribute(:permalink, get_permalink(:id, :name)) }

  def to_s
    name
  end
end
