class Loan < ApplicationRecord
  belongs_to :moneylender
  belongs_to :status
  belongs_to :loan_type
  belongs_to :user
  has_many :extra_fees

  def next_amount_payment
    @next_amount_payment ||= recal_next_amount_payment
  end

  def recal_next_amount_payment
    return 0 unless loan_type
    
    if loan_type.is_profit_balane
      balance * loan_type.profit_by_payment / 100
    else
      (amount_borrowed * loan_type.total_profit) / loan_type.number_of_payments
    end
  end
end
