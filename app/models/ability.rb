class Ability
  include CanCan::Ability

  def initialize(user)

        if user.nil?
                can :read, [Room, Amenity, City]
            elsif user.role? "admin"
                can :manage, [Room, Amenity, City, Booking]
                can :unauthorized_rooms, Room
            elsif user.role? "host"
                
                can :my_rooms, [Room]
                can :read, [Amenity, City, Room, Booking]
                can :create, [Room, Booking]
                can [:update, :destroy], Room do |room|
                    room.user_id == user.id 
                end

                can [:update, :destroy], Booking do |booking|
                    booking.room.user_id == user.id
                end 
                can :unconfirmed_bookings, Booking
                can :create, SpecialPrice 
                can [:update, :destroy], SpecialPrice do |special_price|
                    special_price.room.user_id == user.id
                end
                can [:read, :create], Review
                can [:update, :destroy], Review do |review|
                    review.user_id == user.id
                end

            elsif user.role? "guest"
                can :read, [Room, Amenity, City, Booking]
                can :create, [Room, Booking]
                can [:read, :create], Review
                can [:update, :destroy], Review do |review|
                    review.user_id == user.id
                end
            end 
  end
end




    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities