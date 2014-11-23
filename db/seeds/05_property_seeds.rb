# Property seeds

puts 'Seeding Property'

realestate = Realestate.first
town_ids = Town.pluck(:id)
ncategories = Category.count
category_ids = Category.pluck(:id)
ndetails = Detail.count
detail_ids = Detail.pluck(:id)
description = <<EOF
Esta casa es muy bonita, como todas.. ya que la descripción se repite más que el ajo,
pero siempre esta bien poder ver un poco de texto de relleno además del clásico
Lorem Ipsum que tanto nos ha dado =)
EOF
%w(Antigua Pradera CalpeRock Brillante Smells Gotelé, San-Pito-Pato, Gaviota).each do |title|
  Property.create(title: "Casa #{ title }", realestate: realestate, town_id: town_ids.shuffle.first,
                  ref: '%04d' % rand(50), size: (rand(50) + 7) * 1000, description: description,
                  price_sale: (rand(100) + 7) * 10000, category_ids: category_ids.shuffle.first(rand(ncategories)),
                  detail_ids: detail_ids.shuffle.first(rand(ndetails)))
end
