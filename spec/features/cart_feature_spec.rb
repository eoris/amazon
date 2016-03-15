require 'rails_helper'

RSpec.describe "Cart", type: :feature do

  let(:book1) { create(:book, price: 10) }
  let(:book2) { create(:book) }

  scenario "when cart is empty" do
    visit cart_path
    expect(page).to have_content I18n.t('cart.your_cart_empty')
  end

  scenario "customer add book to cart" do
    visit book_path(book1)
    click_button I18n.t('books.add_to_cart')
    expect(page).not_to have_content I18n.t('cart.your_cart_empty')
    expect(page).to have_content book1.title
  end

  scenario "customer add pare of books to cart" do
    visit book_path(book1)
    fill_in 'book[quantity]', with: 2
    click_button I18n.t('books.add_to_cart')
    expect(page).not_to have_content I18n.t('cart.your_cart_empty')
    expect(page).to have_content book1.title
    expect(page).to have_field(book1.id, with: '2')
  end

  scenario "customer remove book from cart" do
    visit book_path(book1)
    click_button I18n.t('books.add_to_cart')
    visit book_path(book2)
    click_button I18n.t('books.add_to_cart')
    click_link book2.id
    expect(page).to have_content book1.title
    expect(page).not_to have_content book2.title
  end

  scenario "customer apply coupon code" do
    create(:coupon, code: '1234', discount: 0.5)
    visit book_path(book1)
    click_button I18n.t('books.add_to_cart')
    fill_in 'coupon', with: 1234
    click_button I18n.t('cart.update')
    expect(page).to have_content('SUBTOTAL: $5.00')
  end

  scenario "customer empty cart with several books" do
    visit book_path(book1)
    click_button I18n.t('books.add_to_cart')
    visit book_path(book2)
    click_button I18n.t('books.add_to_cart')
    click_link I18n.t('cart.empty_cart')
    expect(page).to have_content I18n.t('cart.your_cart_empty')
    expect(page).not_to have_content book1.title
    expect(page).not_to have_content book2.title
  end

end
