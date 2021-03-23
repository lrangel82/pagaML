class Loan < ApplicationRecord
  belongs_to :moneylender
  belongs_to :status
  belongs_to :loan_type, optional: true
  belongs_to :user
  has_many :extra_fees, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :start_date, presence: true
  validates :loan_date, presence: true
  validates :amount_borrowed, presence: true

  before_save :recalculation

  scope :delayed, -> { where( "next_payment_date <= ? and status_id = ?", Date.today, 1) }
  scope :paied, -> { where({balance: -Float::INFINITY..0, status_id: [2,3] }) }
  scope :coming, -> { where({next_payment_date: (Date.today + 1.day)..(Date.today + 2.day), status_id: 1} ) }
  scope :ok, -> { where({next_payment_date: (Date.today + 3.day)..Date::Infinity.new , status_id: 1} )}
  scope :closed, -> { where(status_id: [4,5]) }

  include ActionView::Helpers::NumberHelper

  def name
     code + ' ' + moneylender.alias + '('+ number_to_currency(amount_borrowed, precision: 0) +')'
  end

  def code
    'ML'+ id.to_s.rjust(4, "0")
  end

  def recalculation
    self.next_payment_date   = recal_next_payment_date
    self.next_amount_payment = recal_next_amount_payment
    self.balance             = balance
    self.end_date            = recal_end_date
    self.status_id = 1 if ( self.balance > 0 && status_id == 2) #PAGADO to OPEN
    self.status_id = 2 if ( self.balance <= 0 && status_id == 1) #PAGADO
    #Rails.logger.info "LARANGEL RECAL: #{self.code} balance:#{self.balance}"
    #self.save!
  end

  def self.to_csv
    require "csv"
      headers = ["id", "persona", "monto", "interes %", "semanas", "FechaIni", "Fecha Fin", "ProximoPago","Es Pago Mensual?", "Pago Semanal / Mensual", "Ganancia","quien", "\#Pagos","Monto Pagado","Resta","Dias Vencido","Pagado","NOTAS"]
      CSV.generate(write_headers: true, headers: headers) do |writer|
         all.order(:id).each do |loan|
            writer <<  [
            loan.code,
            loan.user.complete_name,
            loan.amount_borrowed,
            loan.is_profit_balane ? loan.profit_by_payment * 100 : loan.total_profit * 100,
            loan.number_of_payments,
            loan.start_date.strftime("%Y/%m/%d"),
            loan.end_date.nil? ? "" : loan.end_date.strftime("%Y/%m/%d"),
            loan.next_payment_date.nil? ? "" : loan.next_payment_date.strftime("%Y/%m/%d"),
            loan.is_profit_balane ? 1 : nil,
            loan.next_amount_payment,
            loan.amount_borrowed * (loan.is_profit_balane ? loan.profit_by_payment : loan.total_profit),
            loan.moneylender.user.name[0],
            loan.payments.paied.count,
            loan.payments.sum(:amount),
            loan.balance,
            loan.days_left,
            loan.paied? ? "SI"+loan.moneylender.user.name[0] : loan.moneylender.user.name[0]
         ]
         end
      end
  end

  # def generate_due
  #   return if status_id > 1
  #   payments.all
  # end

  def balance

    return 0 if status_id > 1

    if is_profit_balane
      amount_borrowed - payments.parents.sum(:payment_to_borrowed)
    else
      (amount_borrowed * (total_profit / 100 + 1)) - payments.parents.sum(:amount)
    end
    
  end

  def total_profit
    profit_by_payment * number_of_payments
  end

  def delayed?
    next_payment_date <= Date.today && status_id == 1
  end
  def paied?
    balance <= 0 && (status_id == 2 or status_id == 3)
  end
  def coming?
    Date.today >= (next_payment_date - 2.day) && Date.today < next_payment_date  && status_id == 1
  end
  def ok?
    Date.today < (next_payment_date - 2.day)  && status_id == 1
  end
  def closed?
    status_id == 4 or status_id == 5
  end

  def status_text
    tmp = I18n.t(status.name.downcase)
    return tmp+ " "+ I18n.t(:delayed) if delayed?
    return tmp+ " "+ I18n.t(:aware) if ok?
    tmp
  end

  def days_left
    return nil if status_id > 1
    (next_payment_date - Date.today).to_i
  end

  def last_payment_date
    @last_payment_date ||= payments.maximum(:payment_date)
  end

  def next_amount_payment
    @next_amount_payment ||= recal_next_amount_payment
  end

  def next_payment_date
    @next_payment_date ||= recal_next_payment_date
  end

  # def end_date
  #   @end_date ||= recal_end_date
  # end

  def recal_end_date
    return nil if is_profit_balane 
    return nil if number_of_payments <= 0

    days_to_add = (number_of_payments * payment_frequency_days)
    #days_to_add += extra_fees.sum(:days_added) if extra_fees.count > 0
    start_date + days_to_add.day
  end

  def recal_next_payment_date
   
    #if is_profit_balane
    #  months_to_add = payments.paied.count 
    #  days_to_add = payment_frequency_days
    #else
      months_to_add = 0
      days_to_add = payment_frequency_days * (payments.paied.count + 1)
    #end
    next_payment_date = start_date + months_to_add.month
    next_payment_date = next_payment_date + days_to_add.day
  end

  def recal_next_amount_payment
    #return 0 unless loan_type
    return 0 unless status.is_active?

    if is_profit_balane
      balance * profit_by_payment / 100
    else
      amount_borrowed * (total_profit / 100  + 1) / number_of_payments
    end
  end

  def recal_profit(base_amount = nil)
    #return 0 unless loan_type
    return 0 unless status.is_active?

    _profit=0
    if is_profit_balane
      _profit= balance * profit_by_payment / 100
    else
      _profit= amount_borrowed * profit_by_payment / 100
    end
    return _profit if base_amount.nil? or base_amount >= _profit
    return base_amount if !base_amount.nil? && base_amount < _profit
    return nil
  end

  def recal_payment_to_borroewd(base_amount = nil)
    #return 0 unless loan_type
    return 0 unless status.is_active?
    _profit = recal_profit(base_amount)
    base_amount - _profit
  end


end
