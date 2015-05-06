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
      can :edit, Customer
      can :manage, Address
      can :read, :all
      can :create, User
      can :add_to_cart, Item
      can :remove_from_cart, Item

    elsif user.role? :baker
      can :read, :all
      can :edit, OrderItem

     elsif user.role? :shipper
     can :read, :all
     can :manage, :all
     can :ship_item, OrderItem 
    else 
      can :read, :all
   

    end
  end
end