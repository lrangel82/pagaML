class CreateLoanTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :loan_types do |t|
      t.string :short_name, limit: 50
      t.string :description, limit: 500
      t.integer :payment_frequency_days
      t.boolean :is_profit_balane
      t.integer :number_of_payments
      t.decimal :profit_by_payment
      t.decimal :total_profit
      t.decimal :late_fee
      t.decimal :late_fee_profit
      t.integer :days_added

      t.timestamps
    end
  end
end
