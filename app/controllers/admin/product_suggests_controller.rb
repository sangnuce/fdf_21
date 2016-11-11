class Admin::ProductSuggestsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_product_suggest, except: [:index]

  def index
    @product_suggests = ProductSuggest.order_desc.paginate page: params[:page],
      per_page: Settings.product_suggests.product_suggest_per_page
  end

  def update
    if @product_suggest.update_attributes status: "accept"
      UserMailer.product_suggest_accept(@product_suggest.user).deliver_now
      flash[:success] = t "flash.send_email_success"
      redirect_to admin_product_suggests_path
    else
      flash[:danger] = t "flash.cant_accept"
    end
  end

  def destroy
    if @product_suggest.destroy
      flash[:success] = t "flash.delete_product_suggest_success"
      redirect_to admin_product_suggests_path
    else
      flash[:danger] = t "flash.cant_delete"
    end
  end

  private
  def find_product_suggest
    @product_suggest = ProductSuggest.find_by id: params[:id]
    if @product_suggest.nil?
      flash[:danger] = t "flash.product_suggest_not_found"
      redirect_to admin_product_suggests_path
    end
  end
end
