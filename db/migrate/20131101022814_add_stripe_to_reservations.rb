class AddStripeToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :stripe_customer_token, :string
  end
end
