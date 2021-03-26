class AddCountsToLoanTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_types, :counts, :numeric
    remove_column :loans, :loan_type_id
    #Reload all the catalogo
    LoanType.destroy_all


    LoanType.create(id: 1, short_name: "Mensual 10\% infinito", description: "Pago mensual sin limite de pagos 10%", payment_frequency_days: 30, is_profit_balane: true, number_of_payments: nil, profit_by_payment: 0.1e2, total_profit: nil, late_fee: 0.0, late_fee_profit: 0.0, counts: 2)

   LoanType.create(id: 2, short_name: "12 Semanas 30\%", description: "12 pagos con 30\% de interes total 2.5\% por semana", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 12, profit_by_payment: 0.25e1, total_profit: 0.0, late_fee: 0.0, late_fee_profit: 0.0, counts: 3)

   LoanType.create(id: 3, short_name: "12 Semanas 18\%", description: "12 pago semanales con 18\% de interes total 6\% por mes", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 12, profit_by_payment: 0.15e1, total_profit: 0.0, late_fee: 0.0, late_fee_profit: 0.0, counts: 0)

   LoanType.create(id: 4, short_name: "4 Semanas 10\%", description: "4 pagos semanas con 10\% de interes total", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 4, profit_by_payment: 0.25e1, total_profit: 0.0, late_fee: 0.0, late_fee_profit: 0.0, counts: 1)

   LoanType.create(id: 5, short_name: "Eterno", description: "prestamo al olvido 0 ganancia", payment_frequency_days: 365, is_profit_balane: true, number_of_payments: 1, profit_by_payment: 0.0, total_profit: 0.00e2, late_fee: 0.0e2, late_fee_profit: 0.0, counts: 0)

   LoanType.create(id: 6, short_name: "55 Semanas 6\%", description: "55 pagos con 6\% de interes mensual, 1.5\% por semana", payment_frequency_days: 7, is_profit_balane: false, number_of_payments: 55, profit_by_payment: 0.15e1, total_profit: 0.0, late_fee: 0.0, late_fee_profit: 0.0, counts: 1)

   ActiveRecord::Base.connection.execute("SELECT setval('loan_types_id_seq', (SELECT max(id) FROM loan_types));")
  end
end
