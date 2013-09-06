class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :landline, :string
    add_column :users, :mobile, :string
    add_column :users, :agent, :boolean
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :token, :string
    add_column :users, :refresh_token, :string
  end
end
