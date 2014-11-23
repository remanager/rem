return unless Rails.env.development?

require Rails.root.join('lib', 'database_seed_filler.rb')

database_models = %w(
  Category
  Detail
  Property
  Realestate
  Town
  User
)

seed = DatabaseSeedFiller.new(
  tables_to_empty: database_models,
  development_mode: Rails.env.development?,
  realestate_number: 5,
  property_number: 30,
  category_number: 10,
  detail_number: 15,
  town_number: 7,
  users_pw: '123456'
)

seed.run
