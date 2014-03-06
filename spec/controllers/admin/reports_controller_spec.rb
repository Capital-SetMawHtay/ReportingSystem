require 'spec_helper'

describe Admin::ReportsController do
  describe 'GET#index' do
      before(:each) do
        @admin = create(:user,role: 'admin')
        sign_in(:user,@admin)
        @user1 = create(:user)
        @user2 = create(:user)
        @report1, @report2, @report3 = create(:report,user: @user1,report_date: Date.today),
        create(:report,user: @user2,report_date: Date.today ),
        create(:report,user: @user1,report_date: Date.today.beginning_of_week-5)
        @report4 = create(:report,user: @user2,report_date: Date.today.beginning_of_week+1)
      end

      it 'loads correct reports for the member' do

        get :index
        assigns(:reports).should match_array([@report1,@report2])
      end

      it 'respond with correct status' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'renders correct template' do
        get :index
        expect{response}.to render_template('index')
      end
    end


end
