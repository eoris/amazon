class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :number
      t.integer :cvv
      t.integer :expiration_month
      t.integer :expiration_year
      t.title :firstname
      t.title :lastname

      t.timestamps null: false
    end
  end
end
