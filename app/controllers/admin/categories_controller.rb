class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_category, only: [:destroy, :edit, :update]
  before_action :classifies, except: [:index, :show, :destroy]

  def index
    @categories = if category_name = params[:name]
      Category.name_like(category_name)
        .paginate page: params[:page], per_page: 10
    else
      Category.all.paginate page: params[:page], per_page: 10
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.create_category_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash.category_updated"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "flash.delete_category_success"
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :classify
  end

  def find_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "flash.category_not_found"
      redirect_to admin_categories_path
    end
  end

  def classifies
    @classifies = [[t("admin.categories.category.drink"), :drink],
      [t("admin.categories.category.food"), :food]]
  end
end
