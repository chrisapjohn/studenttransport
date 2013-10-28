class Route < ActiveRecord::Base

  attr_accessible :session_id, :home_point, :away_point, :price, :schedule_order

  belongs_to :session

  has_many :trips

end
