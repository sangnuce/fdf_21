class Supports::Product < ApplicationController
  def initialize params
    @params = params[:params]
  end

  def classifies
    @classifies = [[t("admin.categories.category.drink"), :drink],
      [t("admin.categories.category.food"), :food]]
  end

  def sortings
    @sortings = [[t("products.filter_form.ascending"), :asc],
      [t("products.filter_form.descending"), :desc]]
  end

  def categories
    @categories = unless @params[:classify].blank?
      Category.send @params[:classify]
    else
      Category.all
    end
  end

  def rating
    @rating = Rating.new
  end
end
