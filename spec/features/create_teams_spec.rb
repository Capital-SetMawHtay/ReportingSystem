require 'spec_helper'

describe "CreateTeams" do
  it "creates teams",js: true do
    visit teams_path
    fill_in "Name", :with => "Random"
    click_button "Save"
  end
end
