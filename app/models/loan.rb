class Loan < ApplicationRecord
  belongs_to :moneylender
  belongs_to :status
  belongs_to :loan_type

  def next_amount_payment
    if loan_type.is_profit_balane
      self.balance * loan_type.profit_by_payment / 100
    else
      (self.amount_borrowed * loan_type.total_profit) / loan_type.number_of_payments
    end
  end
end
