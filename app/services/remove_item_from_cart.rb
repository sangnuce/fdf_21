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
    success = false
    if available_item?
      success = true
      @cart ||= Hash.new
      @cart.delete @item.id.to_s
    end
    @flash = success ? :success : :danger
    @message = success ? "flash.delete_product_in_cart_success" :
      "flash.delete_product_in_cart_fail"
    {success: success, hash_data: @cart, flash: @flash, message: @message}
  end

  def available_item?
    @cart[@item.id.to_s].present?
  end
end
