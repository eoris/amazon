class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.title :addres, null: false
      t.integer :zipcode, null: false
      t.title :city, null: false
      t.string :phone, null: false
      t.title :country, null: false

      t.timestamps null: false
    end
  end
end
