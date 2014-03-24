class CreateReportFiles < ActiveRecord::Migration
  def change
    create_table :report_files do |t|
      t.date :file_date
      t.integer :report_id
      t.string :file_path

      t.timestamps
    end
  end
end
