class ReservationsController < ApplicationController
  # GET /reservations
  # GET /reservations.json

  before_filter :authenticate_user!

  def index
    @reservations = Reservation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  def add_to_reservation
    current_reservation.add_ticket(params[:trip_id])
    redirect_to reservations_path(current_reservation.id)
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
    @reservation = Reservation.new
    session["trip_ids"] = params["trip_ids"]
    params["trip_ids"].each do |trip_id|
      @reservation.tickets.build(trip_id: trip_id)
    end
    @reservation.tickets.each do |ticket|
      ticket.fetch_price
    end

    @user = current_user

    if @user.stripe_customer_id

      #Make saved Stripe cards available in the Views
      @cards = Stripe::Customer.retrieve(@user.stripe_customer_id).cards

    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])
    charge = Stripe::Charge.retrieve
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new
    
    @user = current_user

    stripe_card_token = params["reservation"]["stripe_card_token"]

    session["trip_ids"].each do |trip_id|
      @reservation.tickets.build(trip_id: trip_id, user_id: current_user.id, reservation_id: @reservation.id)
    end
    
    @reservation.tickets.each do |ticket|
      ticket.fetch_price
    end

    #Check whether current_user has a Stripe ID
    #If not, create customer, charge the customer, and save the customer.id in User model

    if @user.stripe_customer_id

      #Access Stripe Customer ID
      customer_id = @user.stripe_customer_id

      #Charge the Customer
      charge = Stripe::Charge.create(
        :amount   => @reservation.total_price.to_i*100, # in cents
        :currency => "usd",
        :customer => customer_id
      )

      #Save the Charge ID
      @reservation.charge_id = charge.id

    else

      #Create a Customer
      customer = Stripe::Customer.create(
        :card => stripe_card_token
      )

      #Charge the Customer
      charge = Stripe::Charge.create(
          :amount => @reservation.total_price.to_i*100, # in cents
          :currency => "usd",
          :customer => customer.id
      )

      #Save the Charge ID
      @reservation.charge_id = charge.id

      #Save the Customer ID
      @user.stripe_customer_id = customer.id
      @user.save

    end

    @reservation.user_id = @user.id

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end
end
