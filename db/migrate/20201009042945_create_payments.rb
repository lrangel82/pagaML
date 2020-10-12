class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.belongs_to :loan, null: false, foreign_key: true
      t.decimal :amount
      t.date :payment_date
      t.decimal :profit
      t.decimal :payment_to_borrowed
      t.belongs_to :status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
