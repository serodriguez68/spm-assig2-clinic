# Create admin user
admin_user = User.create!(email: 'alena@alenaclinic.com', name: 'Alena', password: 123456789, password_confirmation: 123456789)
admin_user.admin!
puts 'CREATED ADMIN USER: ' << admin_user.email

# Specialties
Specialty.create!(name: 'Podiatrist')
Specialty.create!(name: 'Naturopath')
Specialty.create!(name: 'Chiropractor')

# Heath Care Professionals
10.times do
  HealthCareProfessional.create!(
    name: Faker::Movies::HarryPotter.character,
    email: Faker::Internet.email,
    consultation_fee: rand(100..200),
    specialty: Specialty.order('RANDOM()').first
  )
end

# Mark some HCPs as Resigned
2.times do
  HealthCareProfessional.order('RANDOM()').first.resign!
end



