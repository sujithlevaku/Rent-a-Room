class User < ApplicationRecord
belongs_to :role
has_many :rooms
has_many :bookings
has_many :reviews
validates :username, length: { maximum: 5 }
validates_presence_of :username,:mobile
  validates_numericality_of :mobile
validates_length_of :mobile, is: 10


before_validation :assign_guest_role, on: :create
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # after_create :assign_guest_role

          def assign_guest_role  
         		     self.role_id =  Role.first.id
          end


          
          def role?(role)
         	 self.role.name ==  role
          end 

end

