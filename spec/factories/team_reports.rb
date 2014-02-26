# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_report do
    content "MyText"
    team_id 1
  end
end
