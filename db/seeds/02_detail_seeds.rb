# Detail seeds

%w(Piscina Paddle Jardín Garaje Gimnasio Ludoteca Solarium ADSL).each do |det_name|
  Detail.create(name: det_name)
end
