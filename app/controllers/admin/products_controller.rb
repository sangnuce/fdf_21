class Admin::ProductsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_categories, except: [:index, :destroy]
  before_action :find_product, except: [:index, :new, :create]

  def index
    @products = if product_name = params[:name]
      Product.available.name_like product_name
    else
      Product.order_desc.available
    end.paginate page: params[:page], per_page: 10
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:info] = t "flash.add_product_success"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "flash.update_product_success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  private
  def product_params
    params.require(:product).permit Product::ATTRIBUTE_PARAMS
  end

  def load_categories
    @categories = Category.all.collect{|category| [category.name, category.id]}
  end

  def find_product
    @product = Product.find_by id: params[:id]
    if @product.nil?
      flash[:danger] = t "flash.product_not_found"
      redirect_to_admin_products_path
    end
  end
end
