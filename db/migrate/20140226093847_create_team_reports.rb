class CreateTeamReports < ActiveRecord::Migration
  def change
    create_table :team_reports do |t|
      t.text :content
      t.string :status
      t.date :report_date
      t.integer :team_id

      t.timestamps
    end
  end
end
