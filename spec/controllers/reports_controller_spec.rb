require 'spec_helper'
describe ReportsController do
  context 'When a member is signed in' do
    before(:each) do
      @team1 = create(:team)
      @member = create(:user,role: 'member',team: @team1)
      sign_in(:user,@member)
    end
    describe 'GET#index' do
      describe 'With Generated Reports' do
        before(:each) do
          @other_user = create(:user)
          @report1, @report2, @report3 = create(:report,user: @member,report_date: Date.today),
                                        create(:report,user: @other_user ),
                                        create(:report,user: @member,report_date: Date.today.beginning_of_week-5)
          @report4 = create(:report,user: @member,report_date: Date.today.beginning_of_week+1)
        end

        it 'loads correct reports for the member' do

          get :index,{team_id: @team1.id, user_id: @member.id}
          assigns(:reports).should match_array([@report1,@report4])
        end
      end

      describe 'With Reports not yet generated' do
        it 'does not load any report of  the member' do
          @report4 = create(:report,user: @member,report_date: Date.today.beginning_of_week-4)
          get :index,{team_id: @team1.id, user_id: @member.id}
          assigns(:reports).should match_array([])
        end
      end

      it 'reponse with 200 and correct template' do
        get :index,{team_id: @team1.id, user_id: @member.id}
        expect(response.status).to eq(200)
        expect{response}.to render_template('index')

      end
    end
    describe 'POST#create' do

      it "redirects to reports path" do
        post :create,user_id: @member.id
        #expect(response).to be_success
        expect(response.status).to eq(302)
      end
      it "create a set of reports for current week" do
        (Report.this_week.where(user_id: @member.id)).should be_empty
        post :create,user_id: @member.id
        (Report.this_week.where(user_id: @member.id)).should_not be_empty
      end

    end

    describe 'PUT#update' do
      it 'updates attributes correctly' do
        report1 = create(:report,user: @member)
        put :update,user_id: report1.user.id, id: report1.id,report: {plan: 'new plan',experience: 'new exp'}
        new_report1=Report.find(report1.id)
        new_report1.plan.should eq('new plan')
        new_report1.experience.should eq('new exp')
      end

      it 'responds with 302' do
        report1 = create(:report,user: @member)
        put :update,user_id: report1.user.id, id: report1.id,report: {plan: 'new plan',experience: 'new exp'}
        expect(response.status).to eq(302)
      end

    end

    describe 'GET#show' do
      before(:each) do
        @report1 = create(:report,user: @member)
      end
      it 'assigns correct report into @report' do

        get :show,{user_id: @member.id,id: @report1.id}
        expect(assigns(:report)).to eq(@report1)
      end

      it 'renders correct show template' do
        get :show,{user_id: @member.id,id: @report1.id}
        expect(response).to render_template("show")
      end

      #describe 'authorization' do
      #  context 'When accessing other member reports' do
      #    before(:each) do
      #      @report2 = create(:report,user: create(:user, role: 'leader'))
      #    end
      #    it 'raises CanCan::AccessDenied exception' do
      #       get :show,{user_id: @report2.user.id,id: @report2.id}
      #        expect(response.status).to eq(403)
      #    end
      #  end
      #end
    end

  end

  context 'When a leader is signed in' do
    before(:each) do
      @team1 = create(:team,name: 'Ruby')
      @member = create(:user,role: 'leader',team: @team1)
      sign_in(:user,@member)
    end
    describe 'GET#index' do
      describe 'With Generated Reports' do
        before(:each) do
          @other_user = create(:user)
          @report1, @report2, @report3 = create(:report,user: @member,report_date: Date.today),
              create(:report,user: @other_user ),
              create(:report,user: @member,report_date: Date.today.beginning_of_week-5)
          @report4 = create(:report,user: @member,report_date: Date.today.beginning_of_week+1)
        end

        it 'loads correct reports for the member' do

          get :index,{team_id: @team1.id, user_id: @member.id}
          assigns(:reports).should match_array([@report1,@report4])
        end
      end

      describe 'With Reports not yet generated' do
        it 'does not load any report of  the member' do
          @report4 = create(:report,user: @member,report_date: Date.today.beginning_of_week-4)
          get :index,{team_id: @team1.id, user_id: @member.id}
          assigns(:reports).should match_array([])
        end
      end

      it 'reponse with 200 and correct template' do
        get :index,{team_id: @team1.id, user_id: @member.id}
        expect(response.status).to eq(200)
        expect{response}.to render_template('index')

      end
    end
    describe 'POST#create' do

      it "redirects to reports path" do
        post :create,user_id: @member.id
        #expect(response).to be_success
        expect(response.status).to eq(302)
      end
      it "create a set of reports for current week" do
        (Report.this_week.where(user_id: @member.id)).should be_empty
        post :create,user_id: @member.id
        (Report.this_week.where(user_id: @member.id)).should_not be_empty
      end

    end

    describe 'PUT#update' do
      it 'updates attributes correctly' do
        report1 = create(:report,user: @member)
        put :update,user_id: report1.user.id, id: report1.id,report: {plan: 'new plan',experience: 'new exp'}
        new_report1=Report.find(report1.id)
        new_report1.plan.should eq('new plan')
        new_report1.experience.should eq('new exp')
      end

      it 'respond with 302' do
        report1 = create(:report,user: @member)
        put :update,user_id: report1.user.id, id: report1.id,report: {plan: 'new plan',experience: 'new exp'}
        expect(response.status).to eq(302)
      end

    end

    describe 'GET#show' do
      before(:each) do
        @report1 = create(:report,user: @member)
      end
      it 'assigns correct report into @report' do

        get :show,{user_id: @member.id,id: @report1.id}
        expect(assigns(:report)).to eq(@report1)
      end

      it 'renders correct show template' do
        get :show,{user_id: @member.id,id: @report1.id}
        expect(response).to render_template("show")
      end

      #describe 'authorization' do
      #  context 'When accessing other member reports' do
      #    before(:each) do
      #      @report2 = create(:report,user: create(:user, role: 'leader'))
      #    end
      #    it 'raises CanCan::AccessDenied exception' do
      #      get :show,{user_id: @report2.user.id,id: @report2.id}
      #      expect(response.status).to eq(403)
      #    end
      #  end
      #end
    end
  end

end
