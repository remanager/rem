class Picture < ActiveRecord::Base
  belongs_to :property
  has_one :realestate, through: :property
  has_attached_file :image, styles: { large: '800x400', medium: '300x150', thumb: '100x50' }
  scope :published, -> { where(published: true) }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image, size: { less_than: 1.megabytes }
end
