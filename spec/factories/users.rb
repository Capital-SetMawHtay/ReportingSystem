# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "user#{n}"}
    email {"#{name}@gmail.com"}
    address "somewhere"
    sequence(:employee_number){|n|"AW-0#{n}"}
    password "user"
    date_of_birth Date.today
    role "member"
    team
  end

end

