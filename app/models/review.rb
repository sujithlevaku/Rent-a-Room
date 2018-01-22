class Review < ApplicationRecord

	belongs_to :user
	belongs_to :room

	validates_presence_of :review,:cleanliness_rating,:safety_rating,:facility_rating,:locality_rating,:room_id
end
