require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CategoriesHelper. For example:
#
# describe CategoriesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CartsHelper, type: :helper do
  context 'order_item_book' do
    it 'find book by id' do
      book = create(:book)

      expect(order_item_book(book.id).id).to eq(book.id)
    end
  end

  context 'order_item_price' do
    it 'count order item price' do
      book = create(:book, price: 7)

      expect(order_item_price(2, book.id)).to eq(14)
    end
  end

  context 'total_items_quantity' do
    it 'count total items quantity' do
      session[:cart] = { 1 => 2, 2 => 3}

      expect(total_items_quantity).to eq(5)
    end
  end

  describe 'cart_count' do
    context 'when cart empty' do
      it 'show "EMPTY"' do
        expect(cart_count).to eq("EMPTY")
      end
    end

    context 'when cart not empty' do
      it 'show count of order items in cart' do
        session[:cart] = { 1 => 2, 2 => 3}

        expect(cart_count).to eq(5)
      end
    end
  end
end
