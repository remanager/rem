class Town < ActiveRecord::Base
  validates_presence_of :name, :postcode

  def to_s
    name
  end
end
