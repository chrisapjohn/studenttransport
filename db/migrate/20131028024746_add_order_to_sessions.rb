class AddOrderToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :display_order, :integer
  end
end
