class Payment < ApplicationRecord
  belongs_to :loan
  belongs_to :status
  has_many :children, class_name: "Payment", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Payment", optional: true

  validates :amount,:payment_date,:profit,:payment_to_borrowed,:status_id, presence: true

  before_save :set_status
 
  scope :parents, -> { where(parent_id: nil) }
  scope :paied, -> { parents.where(status_id: 2) }

  def self.to_csv
      require "csv"
      headers = ["code","id","parent_id", "nombre", "fecha_pago", "monto", "EsPagoMensual", "Interes","Capital"]
      CSV.generate(write_headers: true, headers: headers) do |writer|
         all.order(:payment_date).each do |payment|
            writer << [
               payment.loan.code,
               payment.id,
               payment.parent_id,
               payment.loan.user.complete_name,
               payment.payment_date.nil? ? "" : payment.payment_date.strftime("%Y/%m/%d"),
               payment.amount,
               payment.loan.loan_type.is_profit_balane ? 1 : nil,
               payment.profit,
               payment.payment_to_borrowed
            ]
         end
      end
  end

  def children?
    @has_children ||= children.count > 0
  end

  def is_complete?
    return nil unless parent_id.nil?
    self.amount >= loan.next_amount_payment.round(2)
  end

  private
  def set_status
    if is_complete?
      self.status_id = 2 #paied
    else
      self.status_id = 1 #open
    end
  end
  
end
