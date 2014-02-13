require "spec_helper"

describe "user registration" do
  it "allows new users to register with an email address and password" do
    #visit "/users/sign_up"
    #
    #fill_in "Email",                 :with => "alindeman@example.com"
    #fill_in "Password",              :with => "ilovegrapes"
    #fill_in "Password confirmation", :with => "ilovegrapes"
    #
    #click_button "Sign up"
    #
    #page.should have_content("Welcome! You have signed up successfully.")
  end
end


describe "user sign in" do
  it "allows admin users to sign in" do
    visit "/users/sign_in"

    fill_in "Email",                 :with => "admin@gmail.com"
    fill_in "Password",              :with => "admin"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")
  end
end