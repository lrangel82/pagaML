class AddBanckToLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :clabe, :string, limit: 16
    add_column :loans, :account_number, :integer
    add_column :loans, :bank, :string
  end
end
