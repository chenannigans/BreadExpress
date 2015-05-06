class ItemPricesController < ApplicationController
include BreadExpressHelpers::Cart


  before_action :set_item, only: [:show, :update, :destroy]
  authorize_resource


  
  def index
  
  end

  def edit
      @item_price = Item.find(params[:id])

  end

  def show

  
  end

  def new
    moo
  @item_price = ItemPrice.new

  end

  def create
    boo
    @item_price = ItemPrice.new(item_price_params)

    if @item_price.save

      redirect_to @item_price, notice: "#{@item_price.price} was added to the system."
    else
      render action: 'new'
    end
  end

  def update

    if @item_price.update(item_price_params)
      redirect_to items_path, notice: "Your item was revised in the system."
    else
      render action: 'edit'
    end
  end

  #only destroy items if they haven't ever been shipped i believe
  def destroy
    @item_price.destroy
    redirect_to item_prices, notice: "This item was removed from the system."
  end


  def change_item_price
    @item_price = ItemPrice.new

  end


  private
  def set_item
    @item_price = ItemPrice.find(params[:id])
  end

  def item_price_params
    params.require(:item_price).permit(:item_id, :price, :start_date, :end_date)
  end



  

end