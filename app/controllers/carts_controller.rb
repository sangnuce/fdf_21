class CartsController < ApplicationController
  before_action :logged_in_user
  before_action :find_product, only: :update
  before_action :create_service, only: :update

  def update
    @result = @service.perform
    if @result[:success]
      session[:cart] = @result[:hash_data]
    end

    @supports = Supports::Product.new params: session
    respond_to do |format|
      format.html do
        flash[@result[:flash]] = t @result[:message]
        redirect_to @product
      end
      format.js
    end
  end

  private
  def find_product
    @product = Product.find_by id: (cart_params[:product_id] || params[:id])
    if @product.nil?
      flash[:danger] = t "flash.product_not_found"
      redirect_to products_path
    end
  end

  def cart_params
    params.require(:order).permit :product_id, :quantity
  end

  def create_service
    service_class = case params[:service_type]
    when "add"
      AddItemToCart
    when "update"
      UpdateItemInCart
    when "delete"
      RemoveItemFromCart
    end
    @service = service_class.new cart: session[:cart], item: @product,
      quantity: cart_params[:quantity].to_i
  end
end
