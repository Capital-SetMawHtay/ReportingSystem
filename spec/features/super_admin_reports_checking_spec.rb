require_relative '../support/feature_helpers'
include ActionController::RecordIdentifier
describe "Reports Checking" do
  context "When logged in user is admin" do
    before :each do
      admin_login
    end

    describe 'admin today report checking' do
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

    describe 'admin report viewing' do
      before(:each) do
        @today_report,@yesterday_report = create(:report,report_date: Date.today),create(:report,report_date: Date.today-1)
        @report3 = create(:report,report_date: Date.today)
        visit '/reports'
        within("##{dom_id(@today_report)}") do
          click_link('View Detail')
        end
      end
      it 'shows report detail page' do
        page.should have_content(@today_report.user.name)
        page.should have_content(@today_report.report_date)
        page.should have_content(@today_report.user.team.name)
        page.should have_selector('.report_view')
      end

      it 'shows correct report information' do
        page.should have_content(@today_report.plan)
        page.should have_content(@today_report.experience)
        page.should have_content(@today_report.problem)
        page.should have_content(@today_report.solution)

      end
    end
  end


end