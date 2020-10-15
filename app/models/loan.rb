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

  def recal_next_amount_payment
    return 0 unless loan_type

    if loan_type.is_profit_balane
      balance * loan_type.profit_by_payment / 100
    else
      (amount_borrowed * loan_type.total_profit) / loan_type.number_of_payments
    end
  end
end
