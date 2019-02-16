class Users::Products::BidsController < ApplicationController
  def create
    bid = product.bids.new(user: current_user, amount: bid_amount, open: true)
    success = Users::Products::BidCreator.new(bid, bid_amount, current_user).call

    if success
      flash[:bid_success] = {
        product_id: product.id,
        message: 'You are now the highest bidder!'
      }
    else
      flash[:bid_error] = {
        product_id: product.id,
        message: bid.errors.messages[:amount].first
      }
    end
    redirect_back(fallback_location: product.user)
    # redirect_to user_path(product.user, anchor: product.id)
  end

  def accept
    product = Product.find(params[:id])
    bid = Bid.find(params[:current_bid])
    bid.update(open: false)
    product.update(offered: false, selling_price: bid.amount)
    # and do all the other money stuff.
    redirect_back(fallback_location: product.user)
  end

  private

  def product
    @product ||= Product.find(params[:product])
  end

  def bid_amount
    params.require(:bid).fetch(:amount).to_i
  end

  def user_and_products
    @user = product.user
    @current_user = current_user
    @is_current_user = @user == current_user
    @products = @user.products
  end
end
