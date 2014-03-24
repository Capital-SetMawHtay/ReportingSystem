class CreateAdminmails < ActiveRecord::Migration
  def change
    create_table :adminmails do |t|
      t.string :sender_mail
      t.string :sender_password
      t.string :receiver_mail
      t.string :cc
      t.string :subject
      t.date :date
      t.text :content

      t.timestamps
    end
  end
end
