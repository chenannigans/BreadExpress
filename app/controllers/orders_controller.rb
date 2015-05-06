class OrdersController < ApplicationController
  include BreadExpressHelpers::Cart
    include BreadExpressHelpers::Shipping
        include BreadExpressHelpers::Baking


  before_action :check_login
  before_action :set_order, only: [:show, :update, :destroy]
  authorize_resource
  
  def index

    if logged_in? && current_user.role?(:admin) || current_user.role?(:shipper)
      @pending_orders = Order.not_shipped.chronological.paginate(:page => params[:page]).per_page(5)
      @all_orders = Order.chronological.paginate(:page => params[:page]).per_page(5)

    elsif logged_in? && current_user.role?(:baker)
     
      @bread_baking_list = create_baking_list_for("bread")
      @muffins_baking_list = create_baking_list_for("muffins")

      @pastries_baking_list = create_baking_list_for("pastries")

    else

      @pending_orders = current_user.customer.orders.not_shipped.chronological.paginate(:page => params[:page]).per_page(5)
      @all_orders = current_user.customer.orders.chronological.paginate(:page => params[:page]).per_page(5)
    end 
  end

  def show

    @order_items = @order.order_items.to_a
    if current_user.role?(:customer)
      @previous_orders = current_user.customer.orders.chronological.to_a
    else
      @previous_orders = @order.customer.orders.chronological.to_a
    end
  end

  def new
  @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.date = Date.today

    if current_user.role?(:customer)
    @order.customer_id = current_user.customer.id
    end

    @order.grand_total = calculate_cart_items_cost + calculate_cart_shipping


    if @order.save
      @order.pay
      save_each_item_in_cart(@order)
      clear_cart
      redirect_to @order, notice: "Thank you for ordering from Bread Express."
    else
      render action: 'new'
    end
  end

  def update
    # params[:order][:grand_total] = 

    if @order.update(order_params)
      redirect_to @order, notice: "Your order was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: "This order was removed from the system."
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_id, :address_id, :grand_total, :date, :payment_receipt, :credit_card_number, :expiration_month, :expiration_year)
  end







end