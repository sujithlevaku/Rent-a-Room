class User < ApplicationRecord
belongs_to :role
has_many :rooms
has_many :bookings

before_create :assign_guest_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # after_create :assign_guest_role

          def assign_guest_role         	
         		self.role_id =  Role.first.id
          end


          
          def role?(role)
         	 self.roles.pluck(:name).include? role
          end 

end
