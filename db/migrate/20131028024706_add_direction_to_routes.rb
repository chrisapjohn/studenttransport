class AddDirectionToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :going_away, :boolean
  end
end
