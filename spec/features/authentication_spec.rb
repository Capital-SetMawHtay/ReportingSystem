require_relative '../spec_helper'

describe "Authentication" do
  before :each do
    create(:user,email: "admin@gmail.com",password: "admin")
    create(:team,name: "Ruby")
  end
  describe "user creation" do


    context "when admin is signed in" do

      before :each do
        visit "/users/sign_in"

        fill_in "Email",                 :with => "admin@gmail.com"
        fill_in "Password",              :with => "admin"

        click_button "Sign in"
      end
      it "allows admin to add users" do
        visit "/users"

        click_link "New Member"

        page.should have_content("New member")
        fill_in "Name",               :with => "dbc"
        fill_in "Email",              :with => "dbc@gmail.com"
        fill_in "Password",              :with => "dbc"
        fill_in "Password confirmation", :with => "dbc"
        fill_in "Employee number",               :with => "AW-062"
        choose("member")
        page.select('Ruby',:from => 'user[team_id]')
        click_button "Sign up"
        #
        page.should have_content("User successfully created!")
        page.should have_content("Email: dbc@gmail.com")
        page.should have_content("Team: Ruby")
      end

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

    it "does not allow non-user to sign in" do
      visit "/users/sign_in"

      fill_in "Email" , :with => "noname@gmail.com"
      fill_in "Password", :with => "error"

      click_button "Sign in"

      page.should have_content("Invalid email or password")
    end
  end
end