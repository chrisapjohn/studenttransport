class AddColumnsToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :name, :string
    add_column :sessions, :opening_date, :datetime
    add_column :sessions, :closing_date, :datetime
    add_column :sessions, :cash_close_date, :datetime
    add_column :sessions, :cash_information, :string
  end
end
