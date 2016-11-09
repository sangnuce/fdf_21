class Admin::OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_order, except: [:index]
  before_action :load_status, only: [:edit]

  def index
    @orders = if receiver_phone = params[:receiver_phone]
      Order.order_desc.phone_like receiver_phone
    else
      Order.order_desc
    end.paginate page: params[:page], per_page: 10
  end

  def show
    @order_details = @order.order_products
  end

  def edit
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "flash.update_order_success"
      redirect_to admin_order_path(@order)
    else
      flash[:danger] = t "flash.cant_update_order"
    end
  end

  private
  def order_params
    params.require(:order).permit :status
  end

  def find_order
    @order = Order.find_by id: params[:id]
    if @order.nil?
      flash[:danger] = t "flash.order_not_found"
      redirect_to admin_orders_path
    end
  end

  def load_status
    @statuses = Order.statuses.keys
  end
end
