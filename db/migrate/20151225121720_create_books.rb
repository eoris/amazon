class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, index: true, null: false
      t.text :description
      t.decimal :price, precision: 9, scale: 2, null: false
      t.integer :quantity_in_stock, null: false
      t.belongs_to :category

      t.timestamps null: false
    end
  end
end
