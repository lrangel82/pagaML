class Loan < ApplicationRecord
  belongs_to :moneylender
  belongs_to :status
  belongs_to :loan_type
  belongs_to :user
  has_many :extra_fees
  has_many :payments

  include ActionView::Helpers::NumberHelper

  def name
     code + ' ' + moneylender.alias + '('+ number_to_currency(amount_borrowed, precision: 0) +')'
  end

  def code
    'ML'+ id.to_s.rjust(4, "0")
  end

  def next_amount_payment
    @next_amount_payment ||= recal_next_amount_payment
  end

  def end_date
    return nil if loan_type.is_profit_balane 
    return nil if loan_type.number_of_payments <= 0

    days_to_add = (loan_type.number_of_payments * loan_type.payment_frequency_days)
    days_to_add += extra_fees.sum(:days_added) if extra_fees.count > 0
    enddate = start_date + days_to_add.day
  end

  def recal_next_amount_payment
    return 0 unless loan_type
    return 0 unless status.is_active?

    if loan_type.is_profit_balane
      balance * loan_type.profit_by_payment / 100
    else
      (amount_borrowed * loan_type.total_profit / 100) / loan_type.number_of_payments
    end
  end
end
