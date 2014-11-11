class Realestate < ActiveRecord::Base
  belongs_to :user
  has_many :properties
  has_attachment_file :logo, styles: { thumb: '100>' }
  alias_attribute :agent, :user

  validates_presence_of :name

  def to_s
    name
  end
end
