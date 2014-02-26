class CreateTeamReports < ActiveRecord::Migration
  def change
    create_table :team_reports do |t|
      t.text :content
      t.integer :team_id

      t.timestamps
    end
  end
end
