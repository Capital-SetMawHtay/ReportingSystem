require_relative '../support/feature_helpers'

describe 'Team Reports Management' do

  context 'When team leader is logged in' do
    before(:each) do
      @team1 = create(:team,name: 'ruby')
      @leader = create(:user,role: 'leader',team: @team1)
      leader_login
    end
    it 'allows to view team reports' do
       click_link 'Team Reports'
       page.should have_selector('#team_reports')
    end



  end

end