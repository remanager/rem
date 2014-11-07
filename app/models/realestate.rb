class Realestate < ActiveRecord::Base
  belongs_to :user
  has_many :properties
  alias_attribute :agent, :user

  validates_presence_of :name

  def to_s
    name
  end

  def search(params)
    q = properties

    property = q.find_by(ref: params[:ref])
    return property if property

    if params[:category_ids]
      q = q.joins(properties_categories: :property)
           .where(properties_categories: { category_id: params[:category_ids] })
    end

    if params[:detail_ids]
      q = q.joins(properties_details: :property)
           .where(properties_details: { detail_id: params[:detail_ids] })
           .group('properties.id').having(count: params[:detail_ids].size)
    end

    q.distinct
    # q = 'select p.* from properties p inner join properties_categories pc on p.id = pc.property_id where p.realestate_id = ? and pc.category_id = ?',
    #   id, params[:category_ids]
    # Property.find_by_sql(q)
  end
end
