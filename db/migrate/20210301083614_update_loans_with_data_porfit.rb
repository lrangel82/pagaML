class UpdateLoansWithDataPorfit < ActiveRecord::Migration[6.0]
  def change
   Loan.all.each do |l|
      l.description            = l.loan_type.description
      l.payment_frequency_days = l.loan_type.payment_frequency_days
      l.is_profit_balane       = l.loan_type.is_profit_balane
      l.number_of_payments     = l.loan_type.number_of_payments
      l.profit_by_payment      = l.loan_type.profit_by_payment.nil? ? (l.loan_type.total_profit/l.loan_type.number_of_payments) : l.loan_type.profit_by_payment
      l.save!
    end
    
  end
end
