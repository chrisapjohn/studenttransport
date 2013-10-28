class Ticket < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :trips

  belongs_to :user

  def fetch_price
  	self.price = self.trip.price
  	self.save
  end
  
end
