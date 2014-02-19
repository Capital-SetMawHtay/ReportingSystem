require 'spec_helper'

describe User do

  before { @user = FactoryGirl.create(:user)  }
  subject{@user}
  it "has a name" do
    @user.should respond_to(:name)
    @user.name.should_not be_nil
  end

  it "has an address" do
    @user.should respond_to(:address)
    @user.address.should_not be_nil
  end

  it "does not allow to create a user without name" do
    @user = FactoryGirl.build(:user)
    @user.name = ""
    @user.should_not be_valid
  end
  it "does not allow to create a user without employee number" do
      @user = FactoryGirl.build(:user)
      @user.employee_number = ""
      @user.should_not be_valid
  end
  it "does not allow to create a user without date of birth" do
    @user = FactoryGirl.build(:user)
    @user.date_of_birth = nil
    @user.should_not be_valid
  end
  it "does not allow to create a user without role" do
    @user = FactoryGirl.build(:user)
    @user.role = ''
    @user.should_not be_valid
  end
  it "does not allow to create a user with incorrect role" do
    @user = FactoryGirl.build(:user)
    @user.role = "norole"
    @user.should_not be_valid
  end

  it {should belong_to(:team)}

  describe "User#non_admin" do
    it "excludes admin user" do
      user1, user2, admin= create(:user), create(:user), create(:user,role: "admin")
      User.non_admin.should_not include(admin)
    end
  end

  it "responds to #admin?"do
    @user.should respond_to(:admin?)
  end
  it "responds to #member?"do
    @user.should respond_to(:member?)
  end
  it "responds to #leader?"do
    @user.should respond_to(:leader?)
  end
  context "when role is admin"
  it "returns true for correct role" do
    admin= build(:user,role: "admin")

    (admin.admin?).should be_true
    (admin.member?).should_not be_true
    (admin.leader?).should_not be_true
  end
  context "when role is member" do
    it "returns true for correct role" do
      member= build(:user,role: "member")

      (member.admin?).should_not be_true
      (member.member?).should be_true
      (member.leader?).should_not be_true
    end
  end
  context "when role is leader" do
    it "returns true for correct role" do
      leader= build(:user,role: "leader")

      (leader.admin?).should_not be_true
      (leader.member?).should_not be_true
      (leader.leader?).should be_true
    end
  end





end
