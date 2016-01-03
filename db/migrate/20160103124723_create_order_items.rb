class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.float :price, scale: 2, null: false
      t.integer :quantity, null: false

      t.timestamps null: false
    end
  end
end
