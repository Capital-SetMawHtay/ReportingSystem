require 'spec_helper'

describe TeamsController do
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

    it "loads all of the teams into @teams" do
      team1, team2 = create(:team), create(:team)
      get :index

      expect(assigns(:teams)).to match_array([team1, team2])
    end
  end

  describe "GET #edit" do
    before(:each) do
      @team = create(:team)
      get :edit,id: @team,format: :js
    end
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the correct js template" do
      expect(response).to render_template("edit")
    end

    it "loads correct team into @team" do
      expect(assigns(:team)).to eq(@team)
    end
  end

  describe '#update' do
    before(:each) do
      @team = create(:team,name: 'Ruby')
      put :update,id: @team,format: :js,team: {id: @team.id,name: 'Web'}
    end
    it 'updates the team name' do
      Team.find(@team.id).name.should eq('Web')
    end
    it 'renders correct js template' do
      expect(response).to render_template("update")
    end
  end

  describe '#destroy' do
    before(:each) do
      @team = create(:team)
    end
    it 'reduces total record by 1' do
      expect{delete :destroy,id: @team,format: :js}.to change(Team, :count).by(-1)
    end
    it 'deletes the correct record' do
      delete :destroy,id: @team,format: :js
      (Team.all).should_not include(@team)
    end
    it 'renders the correct js template' do
      delete :destroy,id: @team,format: :js
      expect{response}.to render_template('destroy')
    end
  end
end
