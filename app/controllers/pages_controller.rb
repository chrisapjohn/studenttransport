class PagesController < ApplicationController

	def home
		@sessions = Session.all
		@routes = Route.all
		@trips = Trip.all
	end

	def my_reservations
    	@reservations = current_user.reservations.all
	end

end
