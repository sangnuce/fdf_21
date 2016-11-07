class RatingsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :find_product, only: :create

  def create
    @rating = current_user.ratings.build product: @product,
      rate: rating_params[:rate]
    if @rating.save
      respond_to do |format|
        format.html do
          flash[:success] = t "flash.rate_success"
          redirect_to @product
        end
        format.js
      end
    end
  end

  private
  def find_product
    @product = Product.find_by id: params[:product_id]
    if @product.nil?
      flash[:danger] = t "flash.product_not_found"
      redirect_to products_path
    end
  end

  def rating_params
    params.require(:rating).permit :rate
  end
end
