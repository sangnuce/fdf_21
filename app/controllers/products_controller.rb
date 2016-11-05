class ProductsController < ApplicationController
  def index
    @supports = Supports::Product.new params

    @products = Product.available.in_classify(params[:classify])
      .belongs_to_category(params[:category_id])
      .price_between(params[:from_price], params[:to_price])
      .order_rating(params[:rating]).order_price(params[:order_price])
      .name_like(params[:name]).order_name(params[:order_name])
      .paginate page: params[:page], per_page: Settings.products.products_per_page

    respond_to do |format|
      format.html {render :index}
      format.json {render json: @supports.categories}
      format.js
    end
  end
end
