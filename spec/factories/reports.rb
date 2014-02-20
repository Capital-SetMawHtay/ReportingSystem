# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    plan "My Plan"
    experience "My Experience"
    problem "My Problem"
    solution "My Solution"
    status "My Status"
    review "My Review"
    user
  end
end
