class Town < ActiveRecord::Base
  include ApplicationHelper

  validates_presence_of :name, :postcode
  after_create -> { update_attribute(:permalink, get_permalink(:postcode, :name)) }

  def to_s
    name
  end

  def to_param
    permalink || id
  end
end
