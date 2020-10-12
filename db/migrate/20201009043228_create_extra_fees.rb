class CreateExtraFees < ActiveRecord::Migration[6.0]
  def change
    create_table :extra_fees do |t|
      t.belongs_to :loan, null: false, foreign_key: true
      t.decimal :late_fee
      t.decimal :late_fee_profit
      t.decimal :old_balance
      t.decimal :new_balance

      t.timestamps
    end
  end
end
