class Detail < ActiveRecord::Base
  include ApplicationHelper

  has_many :properties_details
  has_many :properties, through: :properties_details
  validates_presence_of :name
  after_create -> { update_attribute(:permalink, get_permalink(:id, :name)) }

  def to_s
    name
  end
end
