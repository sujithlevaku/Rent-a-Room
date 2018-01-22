class AmenityRoom < ApplicationRecord
	belongs_to :room
	belongs_to :amenity
	validates_presence_of :room_id,:amenity_id
end
