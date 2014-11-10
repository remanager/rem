class Category < ActiveRecord::Base
  include ApplicationHelper

  validates_presence_of :name
  after_create -> { update_attribute(:permalink, get_permalink(:id, :name)) }

  def to_s
    name
  end
end
