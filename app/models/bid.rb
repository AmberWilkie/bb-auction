class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validate :amount do
    errors.add(:amount, "Someone outbid you! Try again.") if product.current_amount_bid > amount
    errors.add(:amount, "Minimum bid for this item is €#{product.min_price}") if product.min_price > amount
  end
end
