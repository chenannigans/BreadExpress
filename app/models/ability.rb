class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    if user.role? :admin
      can :manage, :all
    elsif user.role? :customer
      can :edit, OrderItem
      can :create, Order
      can :create, Customer
      can :create, Address
      can :edit, Address
      can :read, :all
      can :create, User
      can :add_to_cart, Item
      can :remove_from_cart, Item
    end
  end
end