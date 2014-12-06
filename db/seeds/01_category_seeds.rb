# Category seeds

puts 'Seeding Category'

%w(Ofertas Mar Montaña Obra-Nueva).each do |cat_name|
  Category.create(name: cat_name)
end
