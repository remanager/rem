class Comment < ActiveRecord::Base
  belongs_to :realestate
  belongs_to :property

  scope :pending, -> { where('updated_at = created_at') }

  validates :email, presence: true, length: { maximum: 255 }
  validates :text, presence: true, length: { maximum: 2000 }

  def published?
    published
  end

  def publish(state = true)
    update_attribute(:published, state)
  end
end
