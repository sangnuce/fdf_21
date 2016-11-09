class CommentsController < ApplicationController
  before_action :find_product
  before_action :find_comment, only: [:destroy]

  def create
    @comment = @product.comments.build comment_params
    if @comment.save
      @supports = Supports::Product.new params
      respond_to do |format|
        format.html do
          flash[:success] = t "flash.comment_success"
          redirect_to product_path @product
        end
        format.js
      end
    else
      flash[:danger] = t "flash.cant_add_comment"
      redirect_to product_path @product
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "flash.delete_comment"
          redirect_to product_path @product
        end
        format.js
      end
    else
      flash[:danger] = t "flash.cant_delete_comment"
      redirect_to product_path @product
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge user_id: current_user.id
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    if @comment.nil?
      flash[:danger] = t "flash.comment_not_found"
      redirect_to product_path @product
    end
  end

  def find_product
    @product = Product.find_by id: params[:product_id]
    if @product.nil?
      flash[:danger] = t "flash.product_not_found"
      redirect_to products_path
    end
  end
end
