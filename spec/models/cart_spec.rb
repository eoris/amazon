require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '.initialize' do
    it 'init new cart' do
      cart = Cart.new(1)
      expect(cart.session).to eq(1)
    end
  end

  describe '.remove_item_from_cart' do
    it 'remove item from cart' do
      cart = Cart.new({'1' => '1', '2' => '2'})
      cart.remove_item_from_cart('1')
      expect(cart.session).to eq({'2' => '2'})
    end
  end

  describe '.params_valid?' do
    context 'check for valid params' do
      before(:each) do
        create(:book)
        @cart = Cart.new(1)
      end

      it 'return true if params valid' do
        params = {book_id: '1', quantity: '1'}
        expect(@cart.params_valid?(params)).to be true
      end

      it 'return false if book_id 0' do
        params = {book_id: '0', quantity: '1'}
        expect(@cart.params_valid?(params)).to be false
      end

      it 'return false if quantity 10' do
        params = {book_id: '1', quantity: '10'}
        expect(@cart.params_valid?(params)).to be false
      end
    end
  end

  describe '.add_item_to_cart' do
    context 'add item to cart session hash' do
      before(:each) do
        create(:book)
        @cart = Cart.new({})
      end

      it 'return nil if params not valid' do
        expect(@cart.add_item_to_cart({book_id: 0, quantity: 1})).to be_nil
      end

      it 'add hash with book_id as key and quantity as value' do
        @cart.add_item_to_cart({book_id: 1, quantity: 1})
        expect(@cart.session).to eq({ 1 => 1 })
      end

      it 'sum hash if add same book' do
        @cart.add_item_to_cart({book_id: 1, quantity: 1})
        @cart.add_item_to_cart({book_id: 1, quantity: 3})
        @cart.add_item_to_cart({book_id: 2, quantity: 3})
        expect(@cart.session).to eq({1 => 4, 2 =>3})
      end
    end
  end
end
