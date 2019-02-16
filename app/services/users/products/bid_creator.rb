module Users
  module Products
    class BidCreator
      def initialize(bid, bid_amount, current_user)
        @bid = bid
        @product = bid.product
        @bid_amount = bid_amount
        @current_user = current_user
      end

      def call
        if bid.valid?
          current_user.update(money: user_money)
          update_old_bidder_money
        end
        bid.save
      end

      private

      def old_bidder
        product.current_bid&.user
      end

      def same_user_bidding
        old_bidder == current_user
      end

      def user_money
        return current_user.money - bid_amount unless same_user_bidding
        current_user.money - (bid_amount - product.current_amount_bid)
      end

      def update_old_bidder_money
        return unless old_bidder && !same_user_bidding
        old_bidder.update(money: old_bidder.money + product.current_bid.amount)
      end

      attr_accessor :product, :bid_amount, :current_user, :bid
    end
  end
end
