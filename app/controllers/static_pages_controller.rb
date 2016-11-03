class StaticPagesController < ApplicationController
  def show
    if valid_page?
      @categories = Category.all
      @newest_products = Product.available.order_desc.take Settings.products.newest_products_number
      render template: "static_pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist? Pathname.new Rails.root +
      "app/views/static_pages/#{params[:page]}.html.erb"
  end
end
