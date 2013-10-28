class AddColumnsToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :route_id, :integer
    add_column :trips, :going_away, :boolean
    add_column :trips, :departure_date, :datetime
    add_column :trips, :seats, :integer
  end
end
