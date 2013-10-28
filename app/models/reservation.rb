class Reservation < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user

  has_many :tickets

  def add_ticket(trip_id)
  	ticket = tickets.where('trip_id = ?', trip_id).first
  	if ticket
  		ticket.quantity + 1
  		save
  	else
  		reservation.tickets << Ticket.new(trip_id: trip_id, quantity: 1)
  end

  def total_price
  	tickets.to_a.sum(&:price)
  end
  
end
