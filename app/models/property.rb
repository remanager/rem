class Property < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :town
  belongs_to :user
  belongs_to :realestate
  has_many :pictures #order by order =$
  has_many :properties_categories, class_name: 'PropertiesCategories'
  has_many :categories, through: :properties_categories
  has_many :properties_details, class_name: 'PropertiesDetails'
  has_many :details, through: :properties_details

  alias_attribute :owner, :user

  validates_presence_of :ref, :title, :town
  validates :description, length: { maximum: 2000 }
  after_create -> { update_attribute(:permalink, get_permalink(:id, :title)) }

  scope :same_realestate, ->(realestate_id) { Property.where(realestate_id: realestate_id) }
  scope :same_owner, ->(user_id) { Property.where(user_id: user_id) }

  def to_s
    ref
  end

  def picture_url(size = :medium)
    pictures.first.try(:image).try(:url, size)
  end
end
