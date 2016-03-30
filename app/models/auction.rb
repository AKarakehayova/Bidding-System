class Auction < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  belongs_to :best_bidder, :class_name => 'User', :foreign_key => 'best_bidder_id'
end
