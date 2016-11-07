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
    Rating.new
  end

  def cart_item
    Order.new
  end

  def cart_items
    @cart = Hash.new
    @params[:cart] ||= Hash.new
    @params[:cart].each do |product_id, quantity|
      product = Product.find_by id: product_id
      @cart[product] = quantity if product
    end
    @cart
  end

  def cart_amount
    @amount = 0
    @params[:cart] ||= Hash.new
    @params[:cart].each do |product_id, quantity|
      product = Product.find_by id: product_id
      @amount += product.price * quantity.to_i if product
    end
    @amount
  end
end
