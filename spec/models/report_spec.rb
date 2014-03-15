require 'spec_helper'

describe Report do
  it { should allow_mass_assignment_of(:experience) }
  it { should allow_mass_assignment_of(:plan) }
  it { should allow_mass_assignment_of(:problem) }
  it { should allow_mass_assignment_of(:solution) }
  it { should allow_mass_assignment_of(:review) }
  it { should allow_mass_assignment_of(:user_id) }
  it { should allow_mass_assignment_of(:status) }
  it { should allow_mass_assignment_of(:report_date) }
  it {should belong_to(:user)}

  describe "#get_by_team" do
    it "only return reports concerning the given team" do
      team1,team2 = create(:team,name: "ruby"), create(:team,name: "java")
      user1,user2,user3 = create(:user,team: team1),create(:user,team: team1),create(:user,team: team2)
      report1,report2 = create(:report,user: user1),create(:report,user: user2)
      report3 = create(:report,user: user3)

      Report.get_by_team(team1.name).should eq([report1, report2])
    end
  end

  describe '#get_by_date'do
    it 'only return reports by given date' do
      report1,report2 = create(:report,report_date: Date.today),create(:report,report_date: Date.today+1)
      report3 = create(:report,report_date: Date.today)
      Report.get_by_date(Date.today).should eq([report1,report3])

    end
  end

  describe '#today' do
    it 'only return today reports' do
      report1,report2 = create(:report,report_date: Date.today),create(:report,report_date: Date.today+1)
      report3 = create(:report,report_date: Date.today)
      Report.today.should eq([report1,report3])
    end
  end

  describe '#this week' do
    it 'only return reports by this week' do
      report1,report2 = create(:report,report_date: Date.today.beginning_of_week),create(:report,report_date: Date.today+1)
      report3 = create(:report,report_date: Date.today.end_of_week+2)
      (Report.this_week).should_not include(report3)
    end
  end

  describe '#submitted' do
    it 'only return reports that has submitted status' do
      report1, report2 = create(:report,status: 'submitted'), create(:report,status: 'pending')
      (Report.submitted).should_not include(report2)
    end
  end

  describe '#submitted_today' do
    it 'only returns reports that are submitted and report date is today' do
      report1,report2 = create(:report,report_date: Date.today,status: 'submitted'),create(:report,report_date: Date.today,status: 'pending')
      report3 = create(:report,report_date: Date.today.end_of_week+2,status: 'submitted')
      (Report.submitted_today).should match_array([report1])
    end
  end

  describe '#review' do
    it 'update the status as reviewed' do
      report1 = create(:report,status: 'submitted')

      report1.update_review({review: 'very good'})
      (report1.status).should eq('reviewed')
    end
  end
  describe '#reviewed' do
    it 'only return reports that has reviewed status' do
      report1, report2 = create(:report,status: 'reviewed'), create(:report,status: 'sumitted')
      (Report.submitted).should_not include(report2)
    end
  end
  describe '#reviewed_today' do
    it 'only retrieves report that are reviewed today' do
    report1 = create(:report,status: 'submitted',report_date: Date.today)
    report2 = create(:report,status: 'reviewed',report_date: Date.today-1)
    report3 = create(:report,status: 'reviewed',report_date: Date.today)
    (Report.reviewed_today).should match_array([report3])

    end
  end

end
