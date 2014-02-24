class Checkout
  attr_reader :items

  def initialize
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    @items.sum{ |item| item.price }
  end
end

