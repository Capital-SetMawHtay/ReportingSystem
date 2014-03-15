require_relative '../support/feature_helpers'
include ActionController::RecordIdentifier
describe 'Team Leader Report Checking' do
  context 'When leader is logged in' do
    before(:each) do
      @leader = create(:user,email: 'leader@gmail.com',password: 'leader',role: 'leader')
      leader_login
    end

    describe 'leader today team members report checking' do
      before(:each) do
        @other = create(:user,team: create(:team))
        @today_report,@yesterday_report = create(:report,report_date: Date.today,user: @leader,status: 'submitted'),create(:report,report_date: Date.today-1,user: @leader)
        @other_team_report = create(:report,report_date: Date.today, user: @other)
        @report3 = create(:report,report_date: Date.today,user: @leader,status: 'pending')
        click_link 'Team Member Reports'
      end

      it 'shows today reports submitted by team members' do
        page.should have_content('Reports')
        page.should have_selector('#submitted_reports')
        within('#submitted_reports') do
          page.should have_selector("##{dom_id(@today_report)}")
        end
      end

      it 'does not show pending reports' do
        within('#submitted_reports') do
          page.should_not have_selector("##{dom_id(@report3)}")
        end
      end
      it 'does not show previous reports' do
        within('#submitted_reports') do
          page.should_not have_selector("##{dom_id(@yesterday_report)}")
        end
      end

      it 'does not show reports of other team' do
        within('#submitted_reports') do
          page.should_not have_selector("##{dom_id(@other_team_report)}")
        end
      end

      it 'shows view detail action link for each report' do
        within("##{dom_id(@today_report)}") do
          page.should have_selector("a")
          find('a:first-child').should have_content('View Detail')
        end
      end
    end

  end
end