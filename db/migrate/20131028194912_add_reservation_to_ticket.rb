class AddReservationToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :reservation_id, :integer
  end
end
