class AddConductorColumnsToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :conductor_volunteer, :boolean
  	add_column :tickets, :conductor_approved, :boolean
  end
end
