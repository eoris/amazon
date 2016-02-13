class AddFirstnameLastnameTypeToAdresses < ActiveRecord::Migration
  def change
    add_column :addresses, :firstname, :string, null: false
    add_column :addresses, :lastname, :string, null: false
    add_column :addresses, :type, :string, null: false
  end
end
