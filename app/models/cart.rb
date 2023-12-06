class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(product)
    @items << product
  end

  def total_price
    # Logic to calculate total price of items in the cart
  end

  # Add more methods as needed (e.g., remove_item, empty_cart, etc.)
end
