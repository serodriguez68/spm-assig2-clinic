default_password = "123456789"
# Create admin user
admin_user = User.create!(email: 'alena@alenahealth.com', name: 'Alena',
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
test_user = User.create!(email: 'user@e.com', name: 'Test User',
              password: default_password, password_confirmation: default_password,
              address: Faker::Address.full_address,
              phone: Faker::Number.leading_zero_number(10))

10.times do
  User.create!(email: Faker::Internet.email, name: Faker::Name.name,
               password: default_password, password_confirmation: default_password,
               address: Faker::Address.full_address,
               phone: Faker::Number.leading_zero_number(10))
end



# Crate some appointments for today and tomorrow
hcp = HealthCareProfessional.first
slots_to_occupy = [9, 14, 16]

slots_to_occupy.each do |slot|
  datetime_today = Date.today.beginning_of_day + slot.hours
  Appointment.create!(health_care_professional: hcp, user: test_user, start_time: datetime_today)

  datetime_tomorrow = Date.tomorrow.beginning_of_day + slot.hours
  Appointment.create!(health_care_professional: hcp, user: test_user, start_time: datetime_tomorrow)

end


