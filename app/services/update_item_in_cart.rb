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
    success = false
    if available_quantity?
      success = true
      @cart ||= Hash.new
      @cart[@item.id.to_s] = @quantity
    end
    @flash = success ? :success : :danger
    @message = success ? "flash.update_product_in_cart_success" :
      "flash.update_product_in_cart_fail"
    {success: success, hash_data: @cart, flash: @flash, message: @message}
  end

  def available_quantity?
    @item.quantity >= @quantity
  end
end
