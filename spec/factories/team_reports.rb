# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_report do
    content "MyText"
    report_date Date.today
    team
  end

end
