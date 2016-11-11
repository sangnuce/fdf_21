class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: [:new, :show, :create]
  before_action :correct_user, only: [:new, :create, :show]
  before_action :cart_has_product, only: [:new, :create]
  before_action :find_order, only: :show

  def new
    @order = @user.orders.build
  end

  def create
    @order = @user.orders.build order_params
      .merge({order_products_attributes: session[:order_products_attributes]})

    @order.order_amount = 0
    session[:order_products_attributes].each do |cart_item|
      @order.order_amount += cart_item["quantity"] * cart_item["price"]
    end

    if @order.save
      @order.send_new_order_email
      session.delete :order_products_attributes
      flash[:success] = t "flash.order_products_success"
      redirect_to user_order_path(@user, @order)
    else
      render :new
    end
  end

  def show
    @order_details = @order.order_products.paginate page: params[:page],
      per_page: Settings.order_details.products_per_page
  end

  private
  def order_params
    params.require(:order).permit :receiver_name, :receiver_address,
      :receiver_phone, :delivery_time, :remarks
  end

  def correct_user
    redirect_to root_path unless @user.current_user? current_user
  end

  def find_user
    @user = User.find_by id: params[:user_id]
    if @user.nil?
      flash[:danger] = t "flash.user_not_found"
      redirect_to root_path
    end
  end

  def find_order
    @order = @user.orders.find_by id: params[:id]
    if @order.nil?
      flash[:danger] = t "flash.order_not_found"
      redirect_to user_path(@user)
    end
  end

  def cart_has_product
    cart = session[:order_products_attributes] || Array.new
    unless cart.any?
      flash[:danger] = t "flash.cart_not_has_product"
      redirect_to root_path
    end
  end
end
