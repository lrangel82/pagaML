json.extract! loan, :id, :moneylender_id, :status_id, :amount_borrowed, :balance, :loan_date, :start_date, :next_payment_date, :next_amount_payment, :created_at, :updated_at
json.url loan_url(loan, format: :json)
