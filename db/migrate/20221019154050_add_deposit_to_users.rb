class AddDepositToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :deposit, :integer, null: false, default: 0
  end
end
