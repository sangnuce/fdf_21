class ProductSuggestsController < ApplicationController
  before_action :logged_in_user

  def new
    @product_suggest = ProductSuggest.new
  end

  def create
    @product_suggest = current_user.product_suggests.new product_suggest_params
    if @product_suggest.save
      flash[:success] = t "flash.send_suggest_success"
      redirect_to products_path
    else
      render :new
    end
  end

  private
  def product_suggest_params
    params.require(:product_suggest).permit :name, :description
  end
end
