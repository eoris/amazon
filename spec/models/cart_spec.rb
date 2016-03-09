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

      it 'return false if quantity greater then 9' do
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

        expect(@cart.session).to eq({1 => 4, 2 => 3})
      end
    end
  end

  describe '.build_order_items_from_cart' do
    it 'return nil if cart session empty' do
      cart = Cart.new({})

      expect(cart.build_order_items_from_cart).to be_nil
    end

    before(:each) do
      @book1 = create(:book)
      @book2 = create(:book)
      @book3 = create(:book)
      @cart = Cart.new({@book1.id => 1, @book2.id => 2, @book3.id => 3})
    end

    it 'each with class' do
      expect(@cart.build_order_items_from_cart.first).to be_a(OrderItem)
    end

    it 'each with book_id' do
      expect(@cart.build_order_items_from_cart.map(&:book_id)).to match_array([@book1.id, @book2.id, @book3.id])
    end

    it 'each with price' do
      expect(@cart.build_order_items_from_cart.map(&:price)).to match_array([@book1.price*1, @book2.price*2, @book3.price*3])
    end

    it 'each with quantity' do
      expect(@cart.build_order_items_from_cart.map(&:quantity)).to match_array([1, 2, 3])
    end
  end

  describe '.build_order' do
    it 'return nil if cart session empty' do
      cart = Cart.new({})

      expect(cart.build_order(Customer.new)).to be_nil
    end

    before(:each) do
      @book1 = create(:book, price: 3)
      @book2 = create(:book, price: 4)
      @book3 = create(:book, price: 5)
      @cart = Cart.new({@book1.id => 1, @book2.id => 2, @book3.id => 3})
      @customer = create(:customer)
      @order = @cart.build_order(@customer)
    end

    it 'has class' do
      expect(@order).to be_a(Order)
    end

    it 'assign order_id to each order item' do
      expect(@order.order_items.map(&:order_id)).to match_array([@order.id, @order.id, @order.id])
    end

    it 'has total_price' do
      expect(@order.total_price).to eq(26)
    end

    it 'has completed_date' do
      expect(@order.completed_date.strftime('%Y-%m-%d')).to eq(Time.now.strftime('%Y-%m-%d'))
    end

    it 'belongs to customer' do
      expect(@order.customer).to be(@customer)
    end
  end

  describe '.subtotal' do
    it 'return subtotal price' do
      book1 = create(:book, price: 2)
      book2 = create(:book, price: 10)
      book3 = create(:book, price: 10)
      cart = Cart.new({book1.id => 1, book2.id => 2, book3.id => 2})

      expect(cart.subtotal).to eq(42)
    end
  end
end
