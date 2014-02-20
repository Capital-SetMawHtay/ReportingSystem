require 'spec_helper'
include ActionController::RecordIdentifier

describe "CreatTeams" do
  it "creates teams", js: true do
    visit teams_path
    fill_in 'Name', with: 'Random'
    click_button "Save"
  end

  it "deletes teams",js: true do
    @team = create(:team, :name => "Ruby")
    visit teams_path
    within ("##{dom_id(@team)}") do
      expect {click_link('Delete')}. to change(Team, :count).by(-1)
    end
  end

  it "renames teams",js: true do
    @team = create(:team)
    visit teams_path

    within("##{dom_id(@team)}") do
      click_link 'Rename'
    end
    page.should have_selector("#edit_#{dom_id(@team)}")
    find('#team_name').value.should eq(@team.name)
    fill_in "Name",:with=> 'new_name'
    click_button "Save"

    within("##{dom_id(@team)}") do
      page.should have_content("new_name")
    end

    page.should have_selector('#new_team')
    find('#team_name').value.should eq('')

    #click_link("a[href='/teams/#{@team.id}']")
    #find("#edit_form").should have_selector('form')
    #fill_in 'Name', with: 'Rename'
    #click_button "Save"
    #find("#team_name").value.should eq('')
    #find('#team'+@team.id.to_s).should have_content('Rename')

  end
end