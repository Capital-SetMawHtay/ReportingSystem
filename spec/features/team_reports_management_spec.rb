require_relative '../support/feature_helpers'
include ActionController::RecordIdentifier

describe 'Team leader Team Reports Management' do

  context 'When team leader is logged in' do
    before(:each) do
      @team1 = create(:team,name: 'ruby')
      @leader = create(:user,email: 'leader@gmail.com',password: 'leader',role: 'leader',team: @team1)
      leader_login
    end
    it 'allows to view team reports' do
       click_link 'Team Reports'
       page.should have_selector('#team_reports')
    end

    it 'shows correct team reports' do
      r1 = create(:team_report,team: @team1)
      r2 = create(:team_report,team: @team1)
      visit team_team_reports_path(@leader.team)
      within('#team_reports') do
        page.should have_content(r1.report_date)
        page.should have_content(r2.report_date)
      end
    end

    describe 'team report detail' do
      before(:each) do
        @r1 = create(:team_report,team: @team1)
        @r2 = create(:team_report,team: @team1)
      end

      it 'shows team report content' do
        visit team_team_reports_path(@team1)
        within("##{dom_id(@r1)}")do
          click_link 'View Detail'
        end
        page.should have_content('Detail')
        page.should have_content(@r1.report_date)
        page.should have_content(@r1.team.name)
        page.should have_content(@r1.content)
      end
    end
    describe 'team report edit' do
      before(:each) do
        @r1 = create(:team_report,team: @team1)
        @r2 = create(:team_report,team: @team1)
      end

      it 'shows team report content' do
        visit team_team_reports_path(@team1)
        within("##{dom_id(@r1)}")do
          click_link 'Edit'
        end
        page.should have_content('Edit')
        page.should have_content(@r1.report_date)
        page.should have_content(@r1.team.name)
        within("#edit_#{dom_id(@r1)}")do
          find('#team_report_content').value.should eq(@r1.content)
        end
      end


    end


  end

end