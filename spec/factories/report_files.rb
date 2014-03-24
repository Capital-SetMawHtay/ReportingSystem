# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report_file do
    file_date "2014-03-21"
    report_id 1
    file_path "MyString"
  end
end
