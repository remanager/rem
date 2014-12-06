# Create users

User.create(email: 'admin@test.com', role: :admin, password: '123456', password_confirmation: '123456')
User.create(email: 'agent@test.com', role: :agent, password: '123456', password_confirmation: '123456')
