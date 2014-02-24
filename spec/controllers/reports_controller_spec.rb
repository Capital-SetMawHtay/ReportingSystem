require 'spec_helper'

describe ReportsController do
  context "When signed in user is admin" do
    before(:each) do
      sign_in(:user,create(:user,role: "admin"))
    end
    describe "GET #index" do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "loads all of today reports into @reports" do
        report1, report2 = create(:report,report_date: Date.today), create(:report,report_date: Date.yesterday)
        get :index

        expect(assigns(:reports)).to match_array([report1])
      end

    end

    describe "GET #edit" do
      before(:each) {@report = create(:report)}
      it "responds successfully with an HTTP 200 status code" do
        get :edit,id: @report.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the edit template" do

        get :edit,id: @report
        expect(response).to render_template("edit")
      end

      it "loads correct report into @report" do

        get :edit,id: @report

        expect(assigns(:report)).to eq(@report)
      end
    end
    describe "GET #show" do
      before(:each) {@report = create(:report)}
      it "responds successfully with an HTTP 200 status code" do
        get :show,id: @report.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the show template" do

        get :show,id: @report
        expect(response).to render_template("show")
      end

      it "loads correct report into @report" do

        get :show,id: @report

        expect(assigns(:report)).to eq(@report)
      end
    end

    describe "GET# new" do
      it "responds successfully with an HTTP 200 status code" do
        get :new
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
      it "renders the show template" do

        get :new
        expect(response).to render_template("new")
      end
    end
  end

  context "When no user is signed in" do
    before(:each) do
    end
    describe "GET #index" do
      it "responds with a 403 unauthorized" do
        get :index
        expect(response).not_to be_success
        expect(response.status).to eq(403)
      end
    end
    context "when trying to access a single resource" do
      before(:each) do
        @report = create(:report)
      end
      describe "GET #update" do
        it "responds with a 403 unauthorized" do
          post :update,id: @report.id
          expect(response).not_to be_success
          expect(response.status).to eq(403)
        end
      end
      describe "GET #show" do
        it "responds with a 403 unauthorized" do
          get :show,id: @report.id
          expect(response).not_to be_success
          expect(response.status).to eq(403)
        end
      end
      describe "GET #edit" do
        it "responds with a 403 unauthorized" do
          get :edit,id: @report.id
          expect(response).not_to be_success
          expect(response.status).to eq(403)
        end
      end
    end
  end

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

  end
end
