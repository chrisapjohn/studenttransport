class Ticket < ActiveRecord::Base
  attr_accessible :user_id, :trip_id, :price, :quantity, :reservation_id

  belongs_to :trip

  belongs_to :reservation

  belongs_to :user

  def fetch_price
  	self.price = self.trip.price
  	self.save
  end
  
end
