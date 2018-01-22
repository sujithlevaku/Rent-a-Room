class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :room
	validates_presence_of :start_date, :end_date,:room_id,:user_id

	validate :check_valid_dates, on: :create
	validate :check_booking_dates, on: :create
	validate :total_price, on: :create
	after_save :send_msg

	def send_msg

		# require 'uri'
		# require 'net/http'
		url = URI("http://api.msg91.com/api/sendhttp.php?sender=MSGIND&route=4&mobiles=9912343257&authkey=192260AXNboZVcFS875a547ee7&country=91&message=#{self.user.username} your Booking has been done, Waiting for confirmation")

		http = Net::HTTP.new(url.host, url.port)

		request = Net::HTTP::Get.new(url)

		response = http.request(request)

		puts "msg91 - Response#{response.read_body}"

	end


	

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
		if self.room.special_prices.any?
			present_booking = (self.start_date..self.end_date).to_a
			special_price_dates = SpecialPrice.where("room_id = ?", self.room_id)
			self.price = 0
			special_price_dates.each do |special_price|
				present_booking.each do |date|
					if (special_price.start_date..special_price.end_date).to_a.include? date
						self.price += special_price.price
					else
						self.price += self.room.price
					end
				end
			end
		else
			self.price = self.room.price * (self.start_date..self.end_date).to_a.length
		end
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