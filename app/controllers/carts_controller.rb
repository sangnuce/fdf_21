class CartsController < ApplicationController
  before_action :logged_in_user
  before_action :find_product, only: :update
  before_action :init_cart, only: :update
  before_action :create_service, only: :update

  def update
    @result = @service.perform
    if @result[:success]
      session[:order_products_attributes] = @result[:cart]
    end

    @supports = Supports::ProductSupport.new params: session
    respond_to do |format|
      format.html do
        flash[@result[:flash]] = @result[:message]
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

    quantity = cart_params[:quantity].to_i
    if service_class == AddItemToCart
      session[:order_products_attributes].each do |cart_item|
        if cart_item["product_id"] == @product.id
          service_class = UpdateItemInCart
          quantity += cart_item["quantity"]
          break
        end
      end
    end

    @service = service_class.new cart: session[:order_products_attributes],
      item: @product, quantity: quantity
  end

  def init_cart
    session[:order_products_attributes] ||= Array.new
  end
end
