# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Team.destroy_all
admin = User.new
admin.email = 'admin@gmail.com'
admin.name = 'admin'
admin.password = 'admin'
admin.address = 'admin home'
admin.employee_number = 'AW-01'
admin.phone_number = '1234'
admin.role = 'admin'
admin.team_id = 1
admin.date_of_birth = Date.today - 500
admin.save!

5.times do|i|
  team=Team.create!(name: "team#{i}")
  user = User.new
  user.email ="member#{i}@gmail.com"
  user.name = Faker::Company.name
  user.password = 'member'
  user.address = Faker::Address.city
  user.employee_number = "AW-#{i}"
  user.phone_number = '1234'
  user.role = 'member'
  user.team_id = team.id
  user.date_of_birth = Date.today - 5000
  user.save!

  user = User.new
  user.email ="leader#{i}@gmail.com"
  user.name = Faker::Company.name
  user.password = 'leader'
  user.address = Faker::Address.city
  user.employee_number = "AW-#{i}"
  user.phone_number = '1234'
  user.role = 'leader'
  user.team_id = team.id
  user.date_of_birth = Date.today - 5000
  user.save!

end
