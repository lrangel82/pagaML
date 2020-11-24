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

  def recal
    self.next_payment_date   = recal_next_payment_date
    self.next_amount_payment = recal_next_amount_payment
    self.balance             = balance
    self.status_id = 2 if ( self.balance <= 0 && status_id == 1) #PAGADO
    self.save
  end

  def balance
    return nil if loan_type.nil?

    if loan_type.is_profit_balane
      amount_borrowed - payments.sum(:payment_to_borrowed)
    else
      (amount_borrowed * (loan_type.total_profit / 100 + 1)) - payments.sum(:amount)
    end
  end

  def delayed?
    next_payment_date < Time.now && status_id == 1
  end
  def paied?
    balance <= 0 && (status_id == 2 or status_id == 3)
  end
  def ok?
    next_payment_date > Time.now && status_id == 1
  end
  def closed?
    status_id == 4 or status_id == 5
  end

  def next_amount_payment
    @next_amount_payment ||= recal_next_amount_payment
  end

  def next_payment_date
    @next_payment_date ||= recal_next_payment_date
  end

  def end_date
    return nil if loan_type.is_profit_balane 
    return nil if loan_type.number_of_payments <= 0

    days_to_add = (loan_type.number_of_payments * loan_type.payment_frequency_days)
    days_to_add += extra_fees.sum(:days_added) if extra_fees.count > 0
    enddate = start_date + days_to_add.day
  end

  def recal_next_payment_date
    return nil if loan_type.nil?

    if loan_type.is_profit_balane
      months_to_add = payments.count + 1
      days_to_add = loan_type.payment_frequency_days
    else
      months_to_add = 0
      days_to_add = loan_type.payment_frequency_days * (payments.count + 1)
    end
    next_payment_date = start_date + months_to_add.month
    next_payment_date = next_payment_date + days_to_add.day
  end

  def recal_next_amount_payment
    return 0 unless loan_type
    return 0 unless status.is_active?

    if loan_type.is_profit_balane
      balance * loan_type.profit_by_payment / 100
    else
      (amount_borrowed * (loan_type.total_profit / 100 + 1)) / loan_type.number_of_payments
    end
  end

  def recal_profit(base_amount = nil)
    return 0 unless loan_type
    return 0 unless status.is_active?

    _profit=0
    if loan_type.is_profit_balane
      _profit=balance * loan_type.profit_by_payment / 100
    else
      _profit=(amount_borrowed * loan_type.total_profit / 100) / loan_type.number_of_payments
    end
    return _profit if base_amount.nil? or base_amount > _profit
    return nil
  end

  def recal_payment_to_borroewd(base_amount = nil)
    return 0 unless loan_type
    return 0 unless status.is_active?
    _profit = recal_profit(base_amount)
    base_amount - _profit
  end
end
