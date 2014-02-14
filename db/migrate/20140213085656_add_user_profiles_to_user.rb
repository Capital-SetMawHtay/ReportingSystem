class AddUserProfilesToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :name, :string
    add_column :users, :role, :string
    add_column :users, :phone_number, :string
    add_column :users, :employee_number, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :started_date, :date
  end

end
