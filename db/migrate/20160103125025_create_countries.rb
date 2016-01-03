class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.title :name, null: false

      t.timestamps null: false
    end
  end
end
