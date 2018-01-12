class Room < ApplicationRecord
	belongs_to :user
	belongs_to :city
	has_many :bookings
	
	has_many :amenity_rooms
	has_many :amenities, through: :amenity_rooms
	validates_presence_of :name,:price,:rules,:image
	mount_uploader :image, CoverUploader
	before_save :set_values
	before_create :update_guest_to_host



 	def update_guest_to_host 
   			self.user.update_attributes(role_id: Role.last.id)
 	end


	def set_values				
		response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.name}&key=AIzaSyDN5_FPsKTbM_46mqbW604jB7mulmtWZIM")
		has_json = JSON.parse(response.body)
							
			self.latitude = "#{has_json["results"][0]["geometry"]["location"]["lat"]}"
			self.longitude = "#{has_json["results"][0]["geometry"]["location"]["lng"]}"
			self.address = "#{has_json["results"][0]["formatted_address"]}"
			self.description = Faker::Lorem.paragraphs(1, true)
			binding.pry
	end


	def self.search(term, current_page)
	  if term
	    page(current_page).where('name LIKE ?', "%#{term}%").order('id DESC')
	  else
	    page(current_page).order('id DESC') 
	  end
	end



	def self.search(term, page)
		  if term
		    where('name LIKE ?', "%#{term}%").paginate(page: page, per_page: 3).order('id DESC')
		  else
		    paginate(page: page, per_page: 3).order('id DESC') 
		  end
	end





end