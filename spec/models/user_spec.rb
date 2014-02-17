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





end
