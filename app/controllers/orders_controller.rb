class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :find_order

  def show
    @order_details = @order.order_products
  end

  private
  def find_order
    @order = Order.find_by user_id: params[:user_id]
    if @order.nil?
      flash[:danger] = t "flash.order_not_found"
      redirect_to admin_orders_path
    end
  end
end
