class OffFromTotal
  attr_reader :checkout

  def initialize(checkout)
    @checkout = checkout
  end

  def applies?
    @checkout.items.sum{ |item| item.price } > 60
  end

  def product_modifier
  end

  def total_modifier
    0.9
  end
end

