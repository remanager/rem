require 'ffaker'

class DatabaseSeedFiller
  def initialize(opt = {})
    @tables_to_empty = opt[:tables_to_empty] || []
    @development_mode = opt[:development_mode] || false
    @realestate_number = opt[:realestate_number] || 0
    @property_number = opt[:property_number] || 0
    @category_number = opt[:category_number] || 0
    @detail_number = opt[:detail_number] || 0
    @town_number = opt[:town_number] || 0
    @users_pw = opt[:users_pw] || '123456'
  end

  def run
    return false unless development?

    clean_database
    create_admin
    create_realestates
    create_details
    create_towns
    create_categories
    create_properties
    create_owners
    true
  end

  def clean_database
    logging 'Cleaning database...'
    @tables_to_empty.each { |table| table.constantize.delete_all }
  end

  def create_admin
    logging 'Creating admin user...'
    User.create(email: 'admin@test.com', role: :admin, password: @users_pw, password_confirmation: @users_pw)
  end

  def create_realestates
    logging 'Creating realestates...'
    @realestate_number.times do
      FactoryGirl.create(:user_agent_with_realestate)
    end
  end

  def create_details
    logging 'Creating details...'
    @detail_number.times do
      FactoryGirl.create(:detail)
    end
  end

  def create_towns
    logging 'Creating towns...'
    @town_number.times do
      FactoryGirl.create(:town)
    end
  end

  def create_categories
    logging 'Creating categories...'
    @category_number.times do
      FactoryGirl.create(:category)
    end
  end

  def create_properties
    logging 'Creating properties...'

    town_offset = Town.first.id
    category_offset = Category.first.id
    detail_offset = Detail.first.id

    @property_number.times do
      property = FactoryGirl.create(:property, town: Town.find(town_offset + rand(Town.count)))
      category_ids = Category.pluck(:id).shuffle
      rand(3).times { property.categories << Category.find(category_ids.pop) }
      detail_ids = Detail.pluck(:id).shuffle
      rand(5).times { property.details << Detail.find(detail_ids.pop) }
    end
  end

  def create_owners
    logging 'Creating owners...'
    property_ids = Property.pluck(:id).shuffle
    rand(property_ids.size).times do
      Property.find(property_ids.pop).user = FactoryGirl.create(:user)
    end
  end

  def development?
    @development_mode
  end

  private
  def logging(text)
    output = "[DatabaseSeedFiller] #{ Time.current } #{ text }"
    puts text if development?
    Rails.logger.debug output
  end
end
