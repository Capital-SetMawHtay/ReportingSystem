require 'spec_helper'

describe Leader::ReportsController do
  describe 'GET#index' do
    before(:each) do
      @team1, @team2 = create(:team,name: 'Ruby'), create(:team)
      @leader = create(:user,role: 'leader',team: @team1)
      sign_in(:user,@leader)
      @user1 = create(:user,team: @team1 )
      @user2 = create(:user, team: @team2)
      @report1, @report2, @report3 = create(:report,user: @user1,report_date: Date.today,status: 'submitted'),
          create(:report,user: @user2,report_date: Date.today ),
          create(:report,user: @user1,report_date: Date.today.beginning_of_week-5)
      @report4 = create(:report,user: @user1,report_date: Date.today,status: 'reviewed')
    end

    it 'loads submitted reports for the member' do

      get :index,{:team_id => @team1.id}
      assigns(:submitted_reports).should match_array([@report1])
      end
    it 'loads reviewed reports for the member' do

      get :index,{:team_id => @team1.id}
      assigns(:reviewed_reports).should match_array([@report4])
    end

    it 'respond with correct status' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'renders correct template' do
      get :index,{:team_id => @team1.id}
      expect{response}.to render_template('index')
    end

  end

end
