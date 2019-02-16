class Product < ApplicationRecord
  belongs_to :user, required: true
  has_many :bids

  def current_bid
    bids.order('amount desc').first
  end

  def current_amount_bid
    current_bid&.amount || 0
  end
end
