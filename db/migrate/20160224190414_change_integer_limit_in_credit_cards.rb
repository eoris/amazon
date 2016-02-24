class ChangeIntegerLimitInCreditCards < ActiveRecord::Migration
  def change
    change_column :credit_cards, :number, :integer, limit: 8
  end
end
