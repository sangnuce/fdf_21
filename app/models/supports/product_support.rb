class Supports::ProductSupport
  def initialize params
    @params = params[:params]
  end

  def classifies
    @classifies = [[I18n.t("admin.categories.category.drink"), :drink],
      [I18n.t("admin.categories.category.food"), :food]]
  end

  def sortings
    @sortings = [[I18n.t("products.filter_form.ascending"), :asc],
      [I18n.t("products.filter_form.descending"), :desc]]
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

  def cart
    data = {items: Array.new, amount: 0}
    if @params[:order_products_attributes]
      @params[:order_products_attributes].each do |cart_item|
        product = Product.find_by id: cart_item["product_id"]
        if product
          data[:items] << {product: product, quantity: cart_item["quantity"]}
          data[:amount] += cart_item["quantity"] * cart_item["price"]
        end
      end
    end

    data
  end

  def comment
    Comment.new
  end
end
