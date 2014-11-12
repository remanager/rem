class Realestate < ActiveRecord::Base
  belongs_to :user
  has_many :properties
  has_attached_file :logo, styles: { thumb: '100>' }
  alias_attribute :agent, :user

  validates_presence_of :name
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  def to_s
    name
  end
end
