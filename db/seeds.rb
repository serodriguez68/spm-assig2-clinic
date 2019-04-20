default_password = "123456789"
# Create admin user
admin_user = User.create!(email: 'alena@alenaclinic.com', name: 'Alena',
                          password: default_password, password_confirmation: default_password,
                          address: Faker::Address.full_address,
                          phone: Faker::Number.leading_zero_number(10))
admin_user.admin!
puts 'CREATED ADMIN USER: ' << admin_user.email

# Specialties
Specialty.create!(name: 'Podiatrist')
Specialty.create!(name: 'Naturopath')
Specialty.create!(name: 'Chiropractor')

# Heath Care Professionals
10.times do
  HealthCareProfessional.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    consultation_fee: rand(100..200),
    specialty: Specialty.order('RANDOM()').first
  )
end

# Mark some HCPs as Resigned
2.times do
  HealthCareProfessional.order('RANDOM()').first.resign!
end

# Create users
10.times do
  admin_user = User.create!(email: Faker::Internet.email, name: Faker::Name.name,
                            password: default_password, password_confirmation: default_password,
                            address: Faker::Address.full_address,
                            phone: Faker::Number.leading_zero_number(10))
end

