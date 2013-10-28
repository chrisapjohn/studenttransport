class PagesController < ApplicationController

	def home
		@sessions = Session.all
		@routes = Route.all
		@trips = Trip.all
	end

end
