# Create users

puts 'Seeding User'

User.create(email: 'admin@test.com', role: :admin, password: '123456', password_confirmation: '123456',
            status: 1, name: 'admin', surname: 'admin', address: 'admin avenue')
User.create(email: 'agent@test.com', role: :agent, password: '123456', password_confirmation: '123456',
            status: 1, name: 'agent', surname: 'agent', address: 'agent avenue')
