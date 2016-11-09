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
    success = false
    if available_quantity?
      success = true
      @cart ||= Hash.new
      @cart[@item.id.to_s] = @quantity
    end

    @flash = success ? :success : :danger
    @message = success ? "flash.add_product_to_cart_success" :
      "flash.add_product_to_cart_fail"
    {success: success, hash_data: @cart, flash: @flash, message: @message}
  end

  def available_quantity?
    quantity = @cart[@item.id.to_s] || 0
    @quantity += quantity
    @item.quantity >= @quantity
  end
end
