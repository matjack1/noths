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
end

