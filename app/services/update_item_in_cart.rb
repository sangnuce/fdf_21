class UpdateItemInCart
  def initialize args
    @cart = args[:cart]
    @item = args[:item]
    @quantity = args[:quantity]
  end

  def perform
    update_item
  end

  private
  def update_item
    success =  if available_quantity?
      @cart.each_with_index do |item, index|
        if item["product_id"] == @item.id
          @cart[index]["quantity"] = @quantity
          break
        end
      end
      true
    else
      false
    end

    if success
      flash = :success
      message = I18n.t "flash.update_product_in_cart_success"
    else
      flash = :danger
      message = I18n.t "flash.update_product_in_cart_fail"
    end

    {success: success, cart: @cart, flash: flash, message: message}
  end

  def available_quantity?
    @item.quantity >= @quantity
  end
end
