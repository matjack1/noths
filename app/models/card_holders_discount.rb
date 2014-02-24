class CardHoldersDiscount
  attr_reader :checkout

  def initialize(checkout)
    @checkout = checkout
  end

  def applies?
    card_holders.count >= 2
  end

  def product_modifier
    card_holders.map!{ |holder| holder.price = BigDecimal('8.5') }
  end

  def total_modifier
    1
  end

  private

  def card_holders
    @checkout.items.select{ |item| item.code == '001' }
  end
end

