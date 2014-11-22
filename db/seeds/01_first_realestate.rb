# A realestate with some properties to start with.

agent = User.create(email: 'agent@test.com', role: 'agent', password: '123456', password_confirmation: '123456')
realestate = Realestate.create(title: 'Tu Casita', user_id: agent.id)

cat_oferta = Category.create(name: 'Ofertas')
cat_mar = Category.create(name: 'Cerca del Mar')

det_piscina = Detail.create(name: 'Piscina')
det_paddle = Detail.create(name: 'Pista de paddle')
det_jardin = Detail.create(name: 'Jardín')
det_garaje = Detail.create(name: 'Plaza de garaje')
det_gim = Detail.create(name: 'Ginmasio')

pob_benidorm = Town.create(name: 'Benidom')
pob_altea = Town.create(name: 'Altea')
pob_calpe = Town.create(name: 'Calpe')

Property.create(title: 'Casa Antigua', ref: '0001', town: pob_benidorm, categories: [cat_mar],
                details: [det_piscina, det_garaje, realestate_id: realestate.id])
Property.create(title: 'Casa de la pradera', ref: '0002', town: pob_benidorm, categories: [cat_mar, cat_oferta],
                details: [det_jardin, det_garaje, realestate_id: realestate.id])
Property.create(title: 'Calpe park', ref: '0003', town: pob_calpe, categories: [cat_mar],
                details: [det_piscina, det_garaje, det_jardin, det_paddle, realestate_id: realestate.id])
Property.create(title: 'Casa la saca', ref: '0004', town: pob_altea, categories: [cat_oferta],
                details: [det_piscina, det_garaje, realestate_id: realestate.id])
Property.create(title: 'Casa Brillante', ref: '0005', town: pob_altea, categories: [cat_mar],
                details: [det_piscina, det_jardin, det_garaje, realestate_id: realestate.id])
Property.create(title: 'Casa Smells', ref: '0006', town: pob_altea, realestate_id: realestate.id)
