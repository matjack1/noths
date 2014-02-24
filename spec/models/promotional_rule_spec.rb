require 'spec_helper'

# describe PromotionalRule do
#   context '#applies' do
#     let(:item) { build(:product, code: '001', price: 9.25) }
#     let(:checkout) { Checkout.new }
#     let(:rule) { PromotionalRule.new(checkout) }

#     before do
#       2.times { checkout.scan item }
#     end

#     it 'defaults to false' do
#       expect(rule.applies?).to eq false
#     end

#   end
# end

describe OffFromTotal do
  context 'when total is more than 60 it applies a 10% discount' do
    let(:item) { build(:product, price: 40) }
    let(:checkout) { Checkout.new }
    let(:rule) { OffFromTotal.new(checkout) }

    before do
      2.times { checkout.scan item }
    end

    it 'applies if total price is higher than 60' do
      expect(rule.applies?).to eq true
    end

    it 'discounts 10% from total' do
      total = 100

      expect(total * rule.total_modifier).to eq 90
    end
  end
end

describe CardHoldersDiscount do
  let(:item) { build(:product, code: '001') }
  let(:checkout) { Checkout.new }
  let(:rule) { CardHoldersDiscount.new(checkout) }

  before do
    2.times { checkout.scan item }
  end

  context 'when you have more than 2 card holders it lower the price of one' do
    it 'applies if you have more than 2 card holders' do
      expect(rule.applies?).to eq true
    end

    it 'modifies the price of the card holder' do
      rule.product_modifier

      expect(rule.checkout.items.first.price).to eq BigDecimal('8.5')
    end
  end
end

