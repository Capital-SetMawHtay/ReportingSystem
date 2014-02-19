# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    plan "MyText"
    experience "MyText"
    problem "MyText"
    solution "MyText"
    status "MyString"
    review "MyText"
    user
  end
end
