class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :amount_available
      t.bigint :cost
      t.string :product_name
      t.bigint :seller_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
