class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string, null: false
    add_column :users, :provider, :string, null: false
  end
end
