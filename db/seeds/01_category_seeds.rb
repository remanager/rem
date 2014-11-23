# Category seeds

%w(Ofertas 'Cerca del mar' 'Obra nueva').each do |cat_name|
  Category.create(name: cat_name)
end
