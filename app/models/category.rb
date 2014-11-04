class Category < ActiveRecord::Base
  include ApplicationHelper

  validates_presence_of :name
  before_save -> { write_attribute(:permalink, generate_permalink(id, name)) }

  def to_s
    name
  end
end
