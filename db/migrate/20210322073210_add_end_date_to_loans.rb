class AddEndDateToLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :end_date, :date
  end
end
