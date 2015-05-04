class ItemsController < ApplicationController
include BreadExpressHelpers::Cart

 before_action :check_login
  before_action :set_item, only: [:show, :update, :destroy]
  authorize_resource


  
  def index
    if logged_in?
      @active_items = Item.active.alphabetical.paginate(:page => params[:page]).per_page(8)
      @inactive_items = Item.inactive.alphabetical.paginate(:page => params[:page]).per_page(8)

	end  
  end

  def edit
  end

  def show

  	@prices = @item.item_prices.chronological



    if current_user.role?(:customer)
      @similar_items = Item.for_category(@item.category)
    end
    #   @items = current_user.customer.orders.chronological.to_a
    # else
    #   @previous_orders = @order.customer.orders.chronological.to_a
    # end
  end

  def new
    @item = Item.new

  end

  def create
    @item = Item.new(item_params)

    if @item.save

      redirect_to @item, notice: "#{@item.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: "Your item was revised in the system."
    else
      render action: 'edit'
    end
  end

  #only destroy items if they haven't ever been shipped i believe
  def destroy
    @item.destroy
    redirect_to items_url, notice: "This item was removed from the system."
  end

  def add_item_to_cart
        redirect_to items_url, notice: "This item was added to the cart."

    add_item_to_cart(params[:id])
  end

  def get_list_of_items_in_cart
      get_list_of_items_in_cart
    end




  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :picture, :category, :units_per_item, :weight, :active)
  end



	

end