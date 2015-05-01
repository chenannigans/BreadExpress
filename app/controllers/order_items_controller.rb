class OrderItemsController < ApplicationController

 def create

 	if !session[:cart].is_nil?

		add_item_to_cart(current_item.id) 		
 	end

 end

 def new
 	@order_item = OrderItem.new
 end


 

 private

 def set_order_item
 	@order_item = Order.find(params[:id])
 end

 def order_item_params
 	set_item_id
 	params.require(:order_item).permit(:order_id, :item_id, :quantity, :shipped_on)
end

def set_item_id
	params[:order_item][:item_id] = current_item.id
end

end