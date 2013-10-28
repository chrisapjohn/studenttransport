class Trip < ActiveRecord::Base
  
  attr_accessible :route_id, :going_away, :departure_date, :seats

  belongs_to :route

  has_many :tickets

  def fetch_price
  	self.price = self.route.price
  	self.save
  end

end
