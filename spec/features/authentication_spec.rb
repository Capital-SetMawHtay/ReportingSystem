require_relative '../support/feature_helpers'
include ActionController::RecordIdentifier
describe "Authentication" do
  before :each do
    create(:user)
    create(:team,name: "Ruby")
  end
  describe "user creation" do


    context "when admin is signed in" do

      before :each do
        admin_login
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

      it "shows member list" do
        visit '/users'
        page.should have_content('Member List')
        page.should have_selector('.user')
        within('.user') do
          page.should have_link('Edit Profile')
        end
      end
      it "allows admin to edit users" do
        @member = create(:user)
        visit "/users"
        within("##{dom_id(@member)}") do
          click_link('Edit Profile')
        end
        page.should have_content("Edit member")
        find("#user_name").value.should eq(@member.name)
        find("#user_email").value.should eq(@member.email)
        fill_in "Name", :with => "edited_name"
        click_button "Update"
        page.should have_content "User successfully updated"
      end

    end
  end


  describe "user sign in" do
    it "allows admin users to sign in" do
      create(:user,email: 'admin@gmail.com',password: 'admin',role: 'admin')
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

  describe 'user sign out' do
    before(:each) do
      admin_login
    end

    it 'has a sign out link' do
      page.should have_link "sign out"
    end
    it 'allows a logged in user to sign out' do
      click_link 'sign out'
      page.should have_content('Signed out successfully.')
    end
  end
end