class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]
 before_action :check_login
 authorize_resource

 def index
  @orders = OrderItems.all
end

 def create
      @order_item = OrderItem.new(order_item_params)

 	if !session[:cart].is_nil?

		add_item_to_cart(current_item.id) 		
 	end


 end

 def update

    if @order_item.update(order_item_params)
      redirect_to @order_item, notice: "Your order was revised in the system."
    else
      render action: 'edit'
    end

end

 def new
 	@order_item = OrderItem.new
 end

  def edit
      @order_item = OrderItem.find(params[:id])

  end

 def show
  @order_item = OrderItem.find(params[:id])
 end

 def create
    @order_item = OrderItem.new(order_item_params)

    if @order_item.save

      redirect_to @order_item, notice: "#{@order_item.item.name} was added to the system."
    else
      render action: 'new'
    end
  end


  def ship_item

    @order_item = OrderItem.find(params[:id])
    @order_item.shipped_on = Date.today
    @order_item.save!
    redirect_to order_path, notice: "Shipped baby!"
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