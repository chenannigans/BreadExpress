class CartController < ApplicationController
	 include BreadExpressHelpers::Cart

def index
	@cart = create_cart
end

def show
	@cart_items = @orders
end


end