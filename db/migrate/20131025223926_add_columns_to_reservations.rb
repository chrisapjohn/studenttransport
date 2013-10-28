class AddColumnsToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :trip_id, :integer
    add_column :reservations, :user_id, :integer
    add_column :reservations, :number_of_tickets, :integer
  end
end
