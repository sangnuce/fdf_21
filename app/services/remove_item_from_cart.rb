class RemoveItemFromCart
  def initialize args
    @cart = args[:cart]
    @item = args[:item]
  end

  def perform
    remove_item
  end

  private
  def remove_item
    success = if available_item?
      @cart.delete_if {|item| item["product_id"] == @item.id}
      true
    else
      false
    end

    if success
      flash = :success
      message = I18n.t "flash.delete_product_in_cart_success"
    else
      flash = :danger
      message = I18n.t "flash.delete_product_in_cart_fail"
    end

    {success: success, cart: @cart, flash: flash, message: message}
  end

  def available_item?
    @cart.any? {|item| item["product_id"] == @item.id}
  end
end
