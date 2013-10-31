class Reservation < ActiveRecord::Base
  attr_accessible :user_id, :tickets, :tickets_attributes

  belongs_to :user

  has_many :tickets, dependent: :destroy

  accepts_nested_attributes_for :tickets

  #Create new reservation
  #Create new ticket(s), pass in trip_id(s) and current_reservation id


  def add_ticket(trip)
  	existing_ticket = self.tickets.where(:trip_id => trip).first
  	if existing_ticket
  		existing_ticket.quantity = existing_ticket.quantity + 1
  		existing_ticket.save
  		self.save
  	else
  		self.tickets << Ticket.new(trip_id: trip, quantity: 1)
  		self.save
  	end
  end

  def total_price
  	tickets.to_a.sum(&:price)
  end
  
end
