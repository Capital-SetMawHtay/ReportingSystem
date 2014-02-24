require_relative '../support/feature_helpers'
include ActionController::RecordIdentifier

describe "CreatTeams" do
  it "creates teams", js: true do
    visit teams_path
    fill_in 'Name', with: 'Random'
    click_button "Save"
    page.should have_content('Team successfully created')
  end

  it "deletes teams",js: true do
    @team = create(:team, :name => "Ruby")
    count = Team.all.count
    visit teams_path
    within ("##{dom_id(@team)}") do
      click_link 'Delete'
    end
    page.should_not have_selector("##{dom_id(@team)}")
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
  end
  it 'shows member counts of each team' do
    team1 = create(:team)
    user1, user2 = create(:user,team: team1), create(:user,team: team1)
    visit teams_path
    within("##{dom_id(team1)}")do
      page.should have_content(team1.users.count)
    end
  end

end