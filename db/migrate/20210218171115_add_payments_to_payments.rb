class AddPaymentsToPayments < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :parent, null: true, foreign_key: { to_table: :payments }
  end
end
