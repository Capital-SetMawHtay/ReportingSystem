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
  Team.create!(name: "team#{i}")
end