require_relative '../support/feature_helpers'
include ActionController::RecordIdentifier
describe 'Leader Reports Reviewing' do
  before(:each) do
    @team1 = create(:team,name: 'Ruby')
    create(:user,email: 'leader@gmail.com',password: 'leader',role: 'leader',team: @team1)
    leader_login
    @member1 = create(:user,role: 'member',team: @team1)
    @member2 = create(:user,role: 'member',team: @team1)
    @report1 = create(:report,user: @member1,report_date: Date.today,status: 'submitted')
    @report2 = create(:report,user: @member2,report_date: Date.today,status: 'submitted')

  end
  it 'allows leader to add review for team member\'s report' do
    visit leader_team_reports_path
    within("##{dom_id(@report1)}") do
      click_link 'Write Review'
    end
    page.should have_content('Review Report')
    page.should have_content(@report1.plan)
    page.should have_content(@report1.experience)
    page.should have_content(@report1.problem)
    page.should have_content(@report1.solution)
    fill_in 'Review',  :with => 'very good'
    click_button 'Write'
    page.should have_content('Report successfully reviewed')
  end
  context 'After a report is reviewed' do
    before(:each) do
      visit leader_team_reports_path
      within("##{dom_id(@report1)}") do
        click_link 'Write Review'
      end
      fill_in 'Review',  :with => 'very good'
      click_button 'Write'
    end
    it 'adds the reviewed report to reviewed list' do
       within('#submitted_reports')do
         page.should_not have_selector("##{dom_id(@report1)}")
       end
       within('#reviewed_reports')do
         page.should have_selector("##{dom_id(@report1)}")
       end
    end
  end


end