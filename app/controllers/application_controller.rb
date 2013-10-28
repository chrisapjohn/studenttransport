class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_reservation
	  if session[:reservation_id]
	    @current_cart ||= Reservation.find(session[:reservation_id])
	  end
	  if session[:reservation_id].nil?
	    @current_reservation = Reservation.create!
	    session[:reservation_id] = @current_reservation.id
	  end
	  @current_reservation
  end
end
