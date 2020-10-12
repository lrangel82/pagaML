class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.belongs_to :moneylender, null: false, foreign_key: true
      t.belongs_to :status, null: false, foreign_key: true
      t.belongs_to :loan_type, null: false, foreign_key: true
      t.decimal :amount_borrowed
      t.decimal :balance
      t.date :loan_date
      t.date :start_date
      t.date :next_payment_date
      t.decimal :next_amount_payment

      t.timestamps
    end
  end
end
