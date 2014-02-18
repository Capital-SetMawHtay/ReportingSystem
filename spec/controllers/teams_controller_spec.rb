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
    before(:each) {@team = create(:team)}
    it "responds successfully with an HTTP 200 status code" do
      get :edit,id: @team.id
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the edit template" do

      get :edit,id: @team
      expect(response).to render_template("edit")
    end

    it "loads correct team into @team" do

      get :edit,id: @team

      expect(assigns(:team)).to eq(@team)
    end
  end
end
