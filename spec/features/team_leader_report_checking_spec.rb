require_relative '../support/feature_helpers'
include ActionController::RecordIdentifier
describe 'Team Leader Report Checking' do
  context 'When leader is logged in' do
    before(:each) do
      @leader = create(:user,email: 'leader@gmail.com',password: 'leader',role: 'leader')
      leader_login
    end

    describe 'leader today report checking' do
      before(:each) do
        @today_report,@yesterday_report = create(:report,report_date: Date.today),create(:report,report_date: Date.today-1)
        @report3 = create(:report,report_date: Date.today)
        visit '/reports'
      end

      it 'shows today reports' do
        page.should have_content('Reports')
        page.should have_selector('#reports')
        within('#reports') do
          page.should have_selector("##{dom_id(@today_report)}")
        end
      end
      it 'does not show previous reports' do
        within('#reports') do
          page.should_not have_selector("##{dom_id(@yesterday_report)}")
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