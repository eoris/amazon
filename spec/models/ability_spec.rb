require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  describe "abilities of guest" do
    let(:user)      { Customer.new }
    let(:ability)   { Ability.new(user) }

    context 'can' do
      it { expect(ability).to be_able_to(:read, Book) }
      it { expect(ability).to be_able_to(:bestsellers, Book) }
      it { expect(ability).to be_able_to(:read, Category) }
      it { expect(ability).to be_able_to(:read, Author) }
      it { expect(ability).to be_able_to(:read, Rating) }
      it { expect(ability).to be_able_to(:manage, Cart) }
    end

    context 'cannot' do
      it { expect(ability).not_to be_able_to(:manage, :all) }
      it { expect(ability).not_to be_able_to(:new, Order) }
      it { expect(ability).not_to be_able_to(:edit, Order) }
      it { expect(ability).not_to be_able_to(:read, Order) }
      it { expect(ability).not_to be_able_to(:new, OrderItem) }
      it { expect(ability).not_to be_able_to(:edit, OrderItem) }
      it { expect(ability).not_to be_able_to(:read, OrderItem) }
      it { expect(ability).not_to be_able_to(:new, Book) }
      it { expect(ability).not_to be_able_to(:edit, Book) }
      it { expect(ability).not_to be_able_to(:new, Category) }
      it { expect(ability).not_to be_able_to(:edit, Category) }
      it { expect(ability).not_to be_able_to(:new, Author) }
      it { expect(ability).not_to be_able_to(:edit, Author) }
      it { expect(ability).not_to be_able_to(:new, Rating) }
      it { expect(ability).not_to be_able_to(:edit, Rating) }
      it { expect(ability).not_to be_able_to(:new, Admin) }
      it { expect(ability).not_to be_able_to(:edit, Admin) }
      it { expect(ability).not_to be_able_to(:edit, Customer) }
      it { expect(ability).not_to be_able_to(:update_addresses, Customer) }
      it { expect(ability).not_to be_able_to(:new, Country) }
      it { expect(ability).not_to be_able_to(:edit, Country) }
      it { expect(ability).not_to be_able_to(:new, Delivery) }
      it { expect(ability).not_to be_able_to(:edit, Delivery) }
      it { expect(ability).not_to be_able_to(:new, CreditCard) }
      it { expect(ability).not_to be_able_to(:edit, CreditCard) }
    end
  end

  describe "abilities of customer" do
    let(:customer) { create(:customer) }
    let(:ability)  { Ability.new(customer) }

    context 'can' do
      it { expect(ability).to be_able_to(:read, Book) }
      it { expect(ability).to be_able_to(:bestsellers, Book) }
      it { expect(ability).to be_able_to(:read, Category) }
      it { expect(ability).to be_able_to(:read, Author) }
      it { expect(ability).to be_able_to(:read, Rating) }
      it { expect(ability).to be_able_to(:new, Rating) }
      it { expect(ability).to be_able_to(:create, Rating) }
      it { expect(ability).to be_able_to(:manage, Cart) }
      it { expect(ability).to be_able_to(:read, Order) }
      it { expect(ability).to be_able_to(:edit, Customer) }
      it { expect(ability).to be_able_to(:update_addresses, Customer) }
    end

    context 'cannot' do
      it { expect(ability).not_to be_able_to(:manage, :all) }
      it { expect(ability).not_to be_able_to(:new, Order) }
      it { expect(ability).not_to be_able_to(:edit, Order) }
      it { expect(ability).not_to be_able_to(:new, OrderItem) }
      it { expect(ability).not_to be_able_to(:edit, OrderItem) }
      it { expect(ability).not_to be_able_to(:read, OrderItem) }
      it { expect(ability).not_to be_able_to(:new, Book) }
      it { expect(ability).not_to be_able_to(:edit, Book) }
      it { expect(ability).not_to be_able_to(:new, Category) }
      it { expect(ability).not_to be_able_to(:edit, Category) }
      it { expect(ability).not_to be_able_to(:new, Author) }
      it { expect(ability).not_to be_able_to(:edit, Author) }
      it { expect(ability).not_to be_able_to(:edit, Rating) }
      it { expect(ability).not_to be_able_to(:new, Admin) }
      it { expect(ability).not_to be_able_to(:edit, Admin) }
      it { expect(ability).not_to be_able_to(:new, Country) }
      it { expect(ability).not_to be_able_to(:edit, Country) }
      it { expect(ability).not_to be_able_to(:new, Delivery) }
      it { expect(ability).not_to be_able_to(:edit, Delivery) }
      it { expect(ability).not_to be_able_to(:new, CreditCard) }
      it { expect(ability).not_to be_able_to(:edit, CreditCard) }
    end
  end
end
