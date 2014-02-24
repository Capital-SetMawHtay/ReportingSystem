require 'spec/spec_helper'

def member_login

end

def admin_login
  visit "/users/sign_in"

  fill_in "Email",                 :with => "admin@gmail.com"
  fill_in "Password",              :with => "admin"

  click_button "Sign in"
end