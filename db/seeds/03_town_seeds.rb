# Town seeds

puts 'Seeding Town'

%w(Benidorm Altea Calpe Benissa Teulada-Moraira Xabia).each do |town_name|
  Town.create(name: town_name, postcode: '%05d' % rand(10000))
end
