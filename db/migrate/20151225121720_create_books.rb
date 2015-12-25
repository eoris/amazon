class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, index: true, null: false
      t.text :descirption
      t.float :price, scale: 2, null: false
      t.integer :quantity_in_stock, null: false

      t.timestamps null: false
    end
  end
end
