class Realestate < ActiveRecord::Base
  belongs_to :user
  has_many :properties
  alias_attribute :agent, :user

  validates_presence_of :name

  def to_s
    name
  end

  def search(params)
    properties.joins(properties_categories: :property).where(properties_categories: { category_id: params[:category_ids] })
    # q = 'select p.* from properties p inner join properties_categories pc on p.id = pc.property_id where p.realestate_id = ? and pc.category_id = ?',
    #   id, params[:category_ids]
    # Property.find_by_sql(q)
  end
end
