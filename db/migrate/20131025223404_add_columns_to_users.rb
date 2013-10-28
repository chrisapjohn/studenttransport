class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    add_column :users, :phone, :string, :default => ""
    add_column :users, :password, :string, :default => "kenyon"
    add_column :users, :password_confirmation, :string, :default => "kenyon"
  end
end
