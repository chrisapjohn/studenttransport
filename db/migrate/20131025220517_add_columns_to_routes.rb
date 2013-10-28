class AddColumnsToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :session_id, :integer
    add_column :routes, :home_point, :string
    add_column :routes, :away_point, :string
    add_column :routes, :price, :decimal
    add_column :routes, :schedule_order, :integer
  end
end
