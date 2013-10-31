class AddTicketsToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :tickets, :array
  end
end
