class Session < ActiveRecord::Base
  attr_accessible :name, :opening_date, :closing_date, :cash_close_date, :cash_information, :display_order

  has_many :routes

end
