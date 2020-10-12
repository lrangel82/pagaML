class CreateMoneylenders < ActiveRecord::Migration[6.0]
  def change
    create_table :moneylenders do |t|
      t.string :alias
      t.string :clabe, limit: 16
      t.integer :account_number
      t.string :bank

      t.timestamps
    end
  end
end
