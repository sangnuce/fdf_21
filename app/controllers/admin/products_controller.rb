class Admin::ProductsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_categories, only: [:new, :create]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:info] = t "flash.add_product_success"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit Product::ATTRIBUTE_PARAMS
  end

  def find_categories
    @categories = Category.all.collect{|category| [category.name, category.id]}
  end
end
