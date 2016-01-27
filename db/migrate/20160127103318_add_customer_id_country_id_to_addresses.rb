class AddCustomerIdCountryIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :customer_id, :integer
    add_column :addresses, :country_id, :integer
  end
end
