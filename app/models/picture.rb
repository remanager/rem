class Picture < ActiveRecord::Base
  belongs_to Property
  belongs_to Realestate
  has_attached_file :image, styles: { medium: '300x300', thumb: '100x100' }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
