class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :total_price, precision: 9, scale: 2, null: false
      t.datetime :completed_date, null: false
      t.string :state, null: false, default: 'in progress'

      t.timestamps null: false
    end
  end
end
