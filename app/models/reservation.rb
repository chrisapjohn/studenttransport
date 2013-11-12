class Reservation < ActiveRecord::Base
  attr_accessible :user_id, :tickets, :tickets_attributes

  belongs_to :user

  has_many :tickets, dependent: :destroy

  accepts_nested_attributes_for :tickets

  attr_accessor :stripe_card_token  

  def total_price
  	self.tickets.to_a.sum(&:price)
  end
  
end
