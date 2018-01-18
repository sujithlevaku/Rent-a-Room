class BookingsController < ApplicationController
	before_action :authenticate_user!

	  load_and_authorize_resource


	def index
		@bookings = current_user.bookings
	end

	def show 
		@booking = Booking.find(params[:id])
	end	
	def new
		@booking = Booking.new

	end


	def create 
		@booking = Booking.new(booking_params)		
		@booking.user_id = current_user.id		
		if @booking.save			
			redirect_to @booking	
		else
			render action: "new"

		end
	end
		

	def edit
		@booking = Booking.find(params[:id])
	end

	def update
		@booking = Booking.find(params[:id])
		if @booking.update_attributes (booking_params)
			redirect_to room_path(@booking.id)
		else
			render action: "edit"
		end
	end

	def destroy
		@booking = Booking.find(params[:id])
		if @booking.destroy
		redirect_to bookings_path
		end
	end
	
	def unconfirmed_bookings
		@bookings = Booking.where("is_confirmed = ?" , false ) 

	end


private 

	def booking_params
		(params[:booking].permit(:id, :start_date, :end_date,  :room_id, :is_confirmed, :price))
	end

end




