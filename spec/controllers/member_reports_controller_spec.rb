require 'spec_helper'

describe MemberReportsController do
  context 'When a member is signed in' do
    before(:each) do
      @member = create(:user,role: 'member')
      sign_in(:user,@member)
    end

    it 'loads correct reports for the member' do
      other_user = create(:user)
      report1, report2, report3 = create(:report,user: @member,report_date: Date.today),create(:report,user: other_user ),create(:report,user: @member,report_date: Date.today.beginning_of_week-5)
      report4 = create(:report,user: @member,report_date: Date.today.beginning_of_week+1)
      get :index
      expect(assigns(:reports)).to match_array([report1,report4])
    end

    describe 'POST#create' do

      it "redirects to reports path" do
        post :create
        #expect(response).to be_success
        expect(response.status).to eq(302)
      end
      it "create a set of reports for current week" do
        (Report.this_week.where(user_id: @member.id)).should be_empty
        post :create
        (Report.this_week.where(user_id: @member.id)).should_not be_empty
      end

    end

    describe 'PUT#update' do
      it 'updates attributes correctly' do
        report1 = create(:report)
        put :update,id: report1.id,report: {plan: 'new plan',experience: 'new exp'}
        new_report1=Report.find(report1.id)
        new_report1.plan.should eq('new plan')
        new_report1.experience.should eq('new exp')
      end

    end

  end
end
