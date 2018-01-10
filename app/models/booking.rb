class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :room
	validates_presence_of :start_date, :end_date

	validate :check_valid_dates, on: :create
	validate :check_booking_dates, on: :create
	validate :total_price, on: :create

	def check_valid_dates
		if self.start_date < Date.today
			self.errors.add(:error, "Your start date cant be past")
		end
		if self.end_date < self.start_date
			self.errors.add(:error, "Your end date must be greater than start date")
		end
	end




	def check_booking_dates
		present_booking = (self.start_date..self.end_date).to_a
		Booking.where("room_id = ? AND end_date >= ?", self.room_id, Date.today).each do |past_booking|
			(past_booking.start_date..past_booking.end_date).to_a.each do |booked_date|
				if present_booking.include? booked_date
					self.errors.add(:error, "Room is not available at this present booking dates")
				end
				break
			end
		end
	end


	def total_price
		self.price = self.room.price * (self.start_date..self.end_date).to_a.length
	end



end



































































































































	# def booking_date
	# 	date1 = self.start_date
	# 	date2 = self.end_date
	# 	present_date = (date1..date2).to_a
	# 	total_booking = Booking.where("room_id = ?", self.room_id)
	# 	total_booking.each do |booking|
	# 		date3 = booking.start_date
	# 		date4 = booking.end_date
	# 		past_date = (date3..date4).to_a
	# 		present_date.each do |date|
	# 			if past_date.include?(date)
	# 				self.errors.add(:base, "The date you are trying to book is already booked")
	# 			end
	# 		end
	# 		break
	# 	end
	# end