class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    if user.role? :admin

      can :manage, :all

    elsif user.role? :customer
      can :create, Customer



      can :update, Customer do |c|
      c.id = user.customer.id
      end
       can :show, Customer do |c|
        c.id = user.customer.id
      end

 can :show, User do |c|
      c.id = user.customer_id
      end
       can :show, User do |c|
        c.id = user.id
      end



      can :create, Address
      can :edit, Address
      can :read, Address

      can :read, Item
      can :index, Item

      can :read, OrderItem
      can :create, OrderItem

      can :read, Order
      can :create, Order

      can :add_to_cart, Item
      can :remove_from_cart, Item


    elsif user.role? :baker
      can :read, OrderItem
      can :read, Order

      can :read, Item
      can :show, Item



      can :read, Address
      can :edit, Address
      can :create, Address
      can :edit, OrderItem

     elsif user.role? :shipper
     can :read, OrderItem
     can :read, Item
     can :show, Item
     can :read, Order

     can :manage, Address

     can :ship_item, OrderItem 
    

    else 
      can :read, Home
      can :read, Item

   

    end
  end
end