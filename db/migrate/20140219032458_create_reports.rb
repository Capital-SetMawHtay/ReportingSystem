class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :plan
      t.text :experience
      t.text :problem
      t.text :solution
      t.string :status
      t.text :review
      t.date :report_date
      t.integer :user_id

      t.timestamps
    end
  end
end
