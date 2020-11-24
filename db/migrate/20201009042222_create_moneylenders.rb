class CreateMoneylenders < ActiveRecord::Migration[6.0]
  def change
    create_table :moneylenders do |t|
      t.text :alias
      t.text :clabe, limit: 16
      t.integer :account_number
      t.text :bank

      t.timestamps
    end
  end
end
