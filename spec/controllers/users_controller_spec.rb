require 'spec_helper'

describe UsersController do
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

      it "loads all of non-admin users into @users" do
        user1, user2 = create(:user), create(:user)
        get :index

        expect(assigns(:users)).to match_array([user1, user2])
      end

    end

    describe "GET #edit" do
      before(:each) {@user = create(:user)}
      it "responds successfully with an HTTP 200 status code" do
        get :edit,id: @user.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the edit template" do

        get :edit,id: @user
        expect(response).to render_template("edit")
      end

      it "loads correct user into @user" do

        get :edit,id: @user

        expect(assigns(:user)).to eq(@user)
      end
    end
    describe "GET #show" do
      before(:each) {@user = create(:user)}
      it "responds successfully with an HTTP 200 status code" do
        get :show,id: @user.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the show template" do

        get :show,id: @user
        expect(response).to render_template("show")
      end

      it "loads correct user into @user" do

        get :show,id: @user

        expect(assigns(:user)).to eq(@user)
      end
    end
  end
  context "When signed in user is non-admin" do
    before(:each) do
      sign_in(:user,create(:user))
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
        @user = create(:user)
      end
      describe "GET #update" do
        it "responds with a 403 unauthorized" do
          post :update,id: @user.id
          expect(response).not_to be_success
          expect(response.status).to eq(403)
        end
      end
      describe "GET #show" do
        it "responds with a 403 unauthorized" do
          get :show,id: @user.id
          expect(response).not_to be_success
          expect(response.status).to eq(403)
        end
      end
      describe "GET #edit" do
        it "responds with a 403 unauthorized" do
          get :edit,id: @user.id
          expect(response).not_to be_success
          expect(response.status).to eq(403)
        end
      end
    end
  end
end
