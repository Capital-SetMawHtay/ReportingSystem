# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Team.destroy_all
Report.destroy_all
TeamReport.destroy_all

@admin_team = Team.create!(name: 'admin team')
admin = User.new
admin.email = 'admin@gmail.com'
admin.name = 'admin'
admin.password = 'admin'
admin.address = 'admin home'
admin.employee_number = 'AW-01'
admin.phone_number = '1234'
admin.role = 'admin'
admin.team_id = @admin_team.id
admin.date_of_birth = Date.today - 500
admin.save!
@leaders = []
@members = []
@teams = []
5.times do|i|
  team=Team.create!(name: "team#{i}")
  @teams<< team
end
@teams.each_with_index do|t,i|
  10.times do|i|
    user = User.new
    user.email ="#{t.name}member#{i}@gmail.com"
    user.name = Faker::Company.name
    user.password = 'member'
    user.address = Faker::Address.city
    user.employee_number = "AW-#{i}"
    user.phone_number = '1234'
    user.role = 'member'
    user.team_id = t.id
    user.date_of_birth = Date.today - 5000
    user.save!
    @members<< user
  end
  user = User.new
  user.email ="leader#{i}@gmail.com"
  user.name = Faker::Company.name
  user.password = 'leader'
  user.address = Faker::Address.city
  user.employee_number = "AW-#{i}"
  user.phone_number = '1234'
  user.role = 'leader'
  user.team_id = t.id
  user.date_of_birth = Date.today - 5000
  user.save!
  @leaders<< user
end

@count = 0
@members.each do|m|
  @first = Date.today.beginning_of_week
  @last = Date.today.beginning_of_week+4
  10.times do
    (@first..@last).each do |date|
     r = Report.new
     r.plan = Faker::Lorem.sentences(4)
     r.experience = Faker::Lorem.sentences(4)
     r.problem = Faker::Lorem.sentences(4)
     r.solution = Faker::Lorem.sentences(4)
     r.report_date = date
     r.status = 'submitted'
     r.user_id = m.id
     r.save!
     @count += 1
     puts "saving report #{r.report_date}: #{m.email}"
    end
    @first = (@first-7).beginning_of_week
    @last = @first+4
  end
  puts "Total Reports: #{@count}"
end
