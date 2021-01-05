class Payment < ApplicationRecord
  belongs_to :loan
  belongs_to :status

  validates :amount,:payment_date,:profit,:payment_to_borrowed,:status_id, presence: true
 
  def self.to_csv
      require "csv"
      headers = ["id", "nombre", "fecha_pago", "monto", "EsPagoMensual", "Interes","Capital"]
      CSV.generate(write_headers: true, headers: headers) do |writer|
         all.order(:payment_date).each do |payment|
            writer << [
               payment.loan.code,
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
end
