# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_good do
    email "MyString"
    encrypted_password "$2a$10$1fdhR3v9FQEFlEZZD7ZB6u431BzLTMx/FLwhw9bN5vDo6RQB9ahPW"
  end
end

FactoryGirl.define do
  factory :admin_user do
    email "admin@gmail.com"
    encrypted_password "$2a$10$1fdhR3v9FQEFlEZZD7ZB6u431BzLTMx/FLwhw9bN5vDo6RQB9ahPW"
  end
end
