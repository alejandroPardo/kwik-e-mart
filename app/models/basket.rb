class Basket
  attr_reader :items

  def initialize(items = {})
    @items = items
  end

  def add_item(product_id)
    @items[product_id] ||= 0
    @items[product_id] += 1
  end

  def remove_item(product_id)
    return unless @items[product_id]

    @items[product_id] -= 1
    @items.delete(product_id) if @items[product_id] <= 0
  end

  def empty
    @items = {}
  end

  def total_price
    # Logic to calculate total price of items in the cart
  end
end
