class AddOwnerIdToGroups < ActiveRecord::Migration
  def change
    change_table :groups do |t|
      t.integer :owner_id
    end
  end
end
