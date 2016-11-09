class AddItemToCart
  def initialize args
    @cart = args[:cart]
    @item = args[:item]
    @quantity = args[:quantity]
  end

  def perform
    add_item
  end

  private
  def add_item
    success = if available_quantity?
      @cart << {"product_id" => @item.id, "quantity" => @quantity, "price" => @item.price}
      true
    else
      false
    end

    if success
      flash = :success
      message = I18n.t "flash.add_product_to_cart_success"
    else
      flash = :danger
      message = I18n.t "flash.add_product_to_cart_fail"
    end

    {success: success, cart: @cart, flash: flash, message: message}
  end

  def available_quantity?
    @item.quantity >= @quantity
  end
end
