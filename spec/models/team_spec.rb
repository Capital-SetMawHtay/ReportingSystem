require 'spec_helper'

describe Team do
  it "does not allow to create a blank team" do
    Team.new.should_not be_valid
  end
end
