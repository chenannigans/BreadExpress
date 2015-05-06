class ItemsController < ApplicationController
include BreadExpressHelpers::Cart


  before_action :set_item, only: [:show, :update, :destroy]
  authorize_resource


  
  def index
      @active_items = Item.active.alphabetical.paginate(:page => params[:page]).per_page(8)
      @inactive_items = Item.inactive.alphabetical.paginate(:page => params[:page]).per_page(8)

  
  end

  def edit
      @item = Item.find(params[:id])

  end

  def show

    @prices = @item.item_prices.chronological



    if current_user.nil? || current_user.role?(:customer)
      @similar_items = Item.for_category(@item.category)
    end
 
  end

  def new
  @item = Item.new

  end

  def create
    @item = Item.new(item_params)

    if @item.current_price ==nil
      @item.active = false
    end

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

  def add_to_cart

    add_item_to_cart(params[:id])
    redirect_to cart_url, notice: "This item was added to the cart."

  end

  def remove_from_cart
    remove_item_from_cart(params[:id])
    redirect_to cart_url, notice: "This item was removed from the cart."
  end

  def get_list_of_items_in_cart
      get_list_of_items_in_cart
    end

  def calculate_cart_items_cost
      calculate_cart_items_cost
  end



  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :picture, :category, :units_per_item, :weight, :active)
  end



  

end