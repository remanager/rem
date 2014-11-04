class Detail < ActiveRecord::Base
  has_many :properties_details
  has_many :properties, through: :properties_details
  validates_presence_of :name

  def to_s
    name
  end
end
