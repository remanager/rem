# Town seeds

%w(Benidorm Altea Calpe Benissa Teulada-Moraira Xabia).each do |town_name|
  Town.create(name: town_name)
end
