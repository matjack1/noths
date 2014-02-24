class Checkout
  attr_reader :items

  def initialize(promotional_rules = [])
    @items = []
    @promotional_rules = promotional_rules.map{ |rule| rule.new(self) }
  end

  def scan(item)
    @items << item
  end

  def total
    @promotional_rules.each do |rule|
      rule.product_modifier if rule.applies?
    end

    total = @items.sum{ |item| item.price }

    @promotional_rules.each do |rule|
      total *= rule.total_modifier if rule.applies?
    end

    total.round(2)
  end
end

