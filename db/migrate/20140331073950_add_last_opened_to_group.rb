class AddLastOpenedToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :last_opened, :boolean
  end
end
