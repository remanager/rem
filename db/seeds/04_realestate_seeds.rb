# Realestate seeds

agent = User.find_by(role: 'agent')

description = <<EOF
Llevamos más de 50 años dedicandonos a conseguir los hogares más fantabulosos del mundo.
Dedicación extrema, no trabajamos con becarios, siempre a la vanguardia con las tecnologias, etc.
EOF
Realestate.create(user_id: agent.id, name: 'Tu Casita', description: description, address: 'Evergreen Str. 123')
