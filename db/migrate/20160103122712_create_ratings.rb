class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :review
      t.integer :rating
      t.integer :customer_id, foreign_key: true
      t.integer :book_id, foreign_key: true
      t.belongs_to :customer
      t.belongs_to :book

      t.timestamps null: false
    end
  end
end
