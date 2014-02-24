require_relative '../support/feature_helpers'
include ActionController::RecordIdentifier
describe "Member team transfer" do
  before(:each) do
    @team1, @team2 = create(:team,name: 'java'), create(:team,name: 'ruby')
    @user1 = create(:user,team: @team1)
    admin_login
  end

  it 'has a team transfer link' do

    visit users_path
    within("##{dom_id(@user1)}")do
      page.should have_link('Transfer Team')
    end
  end
  context 'When Trasnfer Team link is clicked' do
    before(:each) do
      visit users_path
      within("##{dom_id(@user1)}")do
        click_link 'Transfer Team'
      end
    end
    it 'show team transfer form which puts to correct path',js: true do
      within("##{dom_id(@user1)}")do
        page.should have_selector('form')
      end
    end
    it 'transfer team with ajax',js: true do
      within("##{dom_id(@user1)}") do
        page.select('ruby',:from=>'user[team_id]')
        click_button('Transfer')
        page.should_not have_selector('form')
        find('.team_name').should have_content('ruby')
      end
    end
  end
end