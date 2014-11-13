class Realestate < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user
  has_many :properties
  has_attached_file :logo, styles: { thumb: '100>' }
  alias_attribute :agent, :user

  validates_presence_of :name
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  after_create -> { update_attribute(:permalink, get_permalink(:id, :name)) }

  def to_s
    name
  end

  def search(args = {})
    q = properties

    property = q.find_by(ref: args[:ref])
    return property if property

    if args[:town_id]
      q = q.where(town: args[:town_id])
    end

    if args[:category_ids]
      q = q.joins(properties_categories: :property)
           .where(properties_categories: { category_id: args[:category_ids] })
    end

    if args[:detail_ids]
      q = q.joins(properties_details: :property)
           .where(properties_details: { detail_id: args[:detail_ids] })
           .group('properties.id').having(count: args[:detail_ids].size)
    end

    q.distinct
  end
end
