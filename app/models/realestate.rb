class Realestate < ActiveRecord::Base
  belongs_to :user
  has_many :properties
  alias_attribute :agent, :user

  validates_presence_of :name

  def to_s
    name
  end

  def search(args = {})
    q = properties

    property = q.where(ref: args[:ref])
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
