require 'spec_helper'

describe Checkout do
  let(:checkout) { Checkout.new }
  let(:item) { build(:product) }

  describe '#scan' do
    it 'adds a product to the checkout' do
      checkout.scan(item)

      expect(checkout.items.length).to eq 1
    end
  end

  describe '#total' do
    let(:item) { build(:product, price: 10) }

    before do
      checkout.scan(item)
      checkout.scan(item)
    end

    it 'computes the sum of th items in the checkout' do
      total = checkout.total

      expect(total).to eq 20
    end
  end

  describe 'applies promotional codes correctly' do
    let(:item1) { build(:product, code: '001', price: 9.25) }
    let(:item2) { build(:product, code: '002', price: 45.00) }
    let(:item3) { build(:product, code: '003', price: 19.95) }
    let(:promotional_rules) do
      [
        OffFromTotal,
        CardHoldersDiscount
      ]
    end
    let(:co) { Checkout.new(promotional_rules) }

    context 'first example' do
      before do
        co.scan(item1)
        co.scan(item2)
        co.scan(item3)
      end

      it 'computes the total with the 10% discount' do
        expect(co.total).to eq BigDecimal('66.78')
      end
    end

    context 'second example' do
      before do
        co.scan(item1)
        co.scan(item3)
        co.scan(item1)
      end

      it 'computes the total with the card holders discount' do
        expect(co.total).to eq BigDecimal('36.95')
      end
    end

    context 'third example' do
      before do
        co.scan(item1)
        co.scan(item2)
        co.scan(item1)
        co.scan(item3)
      end

      it 'computes the total and applies both discounts' do
        expect(co.total).to eq BigDecimal('73.76')
      end
    end
  end
end

