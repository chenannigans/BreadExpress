class HomeController < ApplicationController
  include BreadExpressHelpers::Baking
    include BreadExpressHelpers::Cart


  def home


  end

  def about
  end

  def privacy
  end

  def contact
  end

  def cart
  	@cartitems = get_list_of_items_in_cart
    @totalcost = calculate_cart_items_cost
  end





end