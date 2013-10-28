class AddColumnsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :user_id, :integer
    add_column :tickets, :trip_id, :integer
  end
end
