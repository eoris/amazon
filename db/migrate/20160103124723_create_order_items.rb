class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.decimal :price, precision: 9, scale: 2, null: false
      t.integer :quantity, null: false
      t.belongs_to :book
      t.belongs_to :order

      t.timestamps null: false
    end
  end
end
