class Item < ActiveRecord::Base
  #attr_protected :admin
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true
  validates :price, presence: true, :numericality =>{:greater_than_or_equal_to => 0}

  def update_price(price_params)
    if price + (price * 1/10).to_f > price_params[:price].to_f
      false
    end
  end
end
