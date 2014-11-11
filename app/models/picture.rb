class Picture < ActiveRecord::Base
  belongs_to :property
  has_one :realestate, through: :property
  has_attached_file :image, styles: { medium: '300x300', thumb: '100x100' }
  scope :published, -> { where(published: true) }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
