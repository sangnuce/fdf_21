class ProductsController < ApplicationController
  before_action :find_product, only: :show

  def index
    @supports = Supports::Product.new params: params
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

  def show
    @supports = Supports::Product.new params: session
  end

  private
  def find_product
    @product = Product.find_by id: params[:id]
    if @product.nil? || @product.not_available?
      flash[:danger] = t "flash.product_not_found"
      redirect_to products_path
    end
  end
end
