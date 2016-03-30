class ItemsController < ApplicationController
  before_action :authorize
  require 'date'
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end


  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @item = Item.new(item_params)
    @item.best_bidder_id = current_user.id
    if @item.save
      redirect_to item_path(@item)
    else render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.deadline < Date.today
      flash[:notice] = "The bidding for this item has ended on #{@item.deadline}"
      redirect_to items_path
    elsif @item.best_bidder_id && @item.best_bidder_id == current_user.id
      flash[:notice] = 'The last bid for this item was already made by you.'
     redirect_to item_path
    elsif @item.price + (@item.price * 1/10).to_f > price_params[:price].to_f
      flash[:notice] = 'The new bid must be at least 10% bigger than the last one'
      render :edit
    elsif @item.update(price_params)
      if @item.save
        @item.best_bidder_id = current_user.id
        redirect_to(@item)
      else render :edit
      end
    else render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:title, :description, :price, :deadline)
  end

  def price_params
    params.require(:item).permit(:price)
  end
end
