class Users::ProductsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product = current_user.products.new
  end

  def create
    product = current_user.products.new(product_params)
    if product.save
      redirect_to user_path(current_user)
    else
      flash[:product_error] = product.errors.messages.map{|error| "#{error.key} #{error.value}"}.join(', ')
    end
  end

  def update
    Product.find(params[:id]).update(offered: params[:offered])
    redirect_to user_path(current_user)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :min_price, :image)
  end
end
