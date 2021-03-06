require 'spec/spec_helper'

def member_login
  visit "/users/sign_in"

  fill_in "Email",                 :with => "member@gmail.com"
  fill_in "Password",              :with => "member"

  click_button "Sign in"
end

def leader_login
  visit "/users/sign_in"

  fill_in "Email",                 :with => "leader@gmail.com"
  fill_in "Password",              :with => "leader"

  click_button "Sign in"
end

def admin_login
  create(:user,email: 'admin@gmail.com',password: 'admin',role: 'admin')
  visit "/users/sign_in"

  fill_in "Email",                 :with => "admin@gmail.com"
  fill_in "Password",              :with => "admin"

  click_button "Sign in"
end