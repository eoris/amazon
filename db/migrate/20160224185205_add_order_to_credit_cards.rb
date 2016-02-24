class AddOrderToCreditCards < ActiveRecord::Migration
  def change
    add_reference :credit_cards, :order, index: true, foreign_key: true
  end
end
