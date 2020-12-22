namespace :export do
  desc "TODO a export to cvs files"

  task loans: :environment do
    require "csv"
    csv_text = "#{Rails.root.join("db", "prestamos_export.csv")}"
    headers = ["id", "persona", "monto", "interes %", "semanas", "FechaIni", "Fecha Fin", "ProximoPago","Es Pago Mensual?", "Pago Semanal / Mensual", "Ganancia","quien", "\#Pagos","Monto Pagado","Resta","Dias Vencido","Pagado","NOTAS"]

    CSV.open(csv_text, 'w', write_headers: true, headers: headers) do
    |writer|
      Loan.all.order(:id).each do |loan|
         writer << [
            loan.code,
            loan.user.complete_name,
            loan.amount_borrowed,
            loan.loan_type.is_profit_balane ? loan.loan_type.profit_by_payment * 100 : loan.loan_type.total_profit * 100,
            loan.loan_type.number_of_payments,
            loan.start_date.strftime("%y/%m/%d"),
            loan.end_date.nil? ? "" : loan.end_date.strftime("%y/%m/%d"),
            loan.next_payment_date.nil? ? "" : loan.next_payment_date.strftime("%y/%m/%d"),
            loan.loan_type.is_profit_balane ? 1 : nil,
            loan.next_amount_payment,
            loan.amount_borrowed * (loan.loan_type.is_profit_balane ? loan.loan_type.profit_by_payment : loan.loan_type.total_profit),
            loan.moneylender.user.name[0],
            loan.payments.count,
            loan.payments.sum(:amount),
            loan.balance,
            loan.days_left,
            loan.paied? ? "SI"+loan.moneylender.user.name[0] : loan.moneylender.user.name[0]
         ]
      end
    end
    puts "Finish the export to #{csv_text}"
    
  end

  task payments: :environment do
    require "csv"
    csv_text = "#{Rails.root.join("db", "abonoss_export.csv")}"
    headers = ["id", "nombre", "fecha_pago", "monto", "EsPagoMensual", "Interes","Capital"]

    CSV.open(csv_text, 'w', write_headers: true, headers: headers) do
    |writer|
      Payment.all.order(:payment_date).each do |payment|
         writer << [
            payment.loan.code,
            payment.loan.user.complete_name,
            payment.payment_date.nil? ? "" : payment.payment_date.strftime("%y/%m/%d"),
            payment.amount,
            payment.loan.loan_type.is_profit_balane ? 1 : nil,
            payment.profit,
            payment.payment_to_borrowed
         ]
      end
    end
    puts "Finish the export to #{csv_text}"
    
  end
end