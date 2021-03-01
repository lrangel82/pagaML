class ChangeNullForLoanType < ActiveRecord::Migration[6.0]
  def change
   change_column_null :loans, :loan_type_id, true
  end
end
