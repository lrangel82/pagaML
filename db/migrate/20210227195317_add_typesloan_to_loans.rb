class AddTypesloanToLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :payment_frequency_days, :integer
    add_column :loans, :is_profit_balane, :boolean
    add_column :loans, :number_of_payments, :integer
    add_column :loans, :profit_by_payment, :decimal
    add_column :loans, :description, :text
  end
end
