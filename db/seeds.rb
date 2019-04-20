

# Create admin user
admin_user = User.create!(email: 'alena@alenaclinic.com', name: 'Alena', password: 123456789, password_confirmation: 123456789)
admin_user.admin!
puts 'CREATED ADMIN USER: ' << admin_user.email
