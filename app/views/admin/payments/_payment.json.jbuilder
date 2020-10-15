json.extract! payment, :id, :loan_id, :amount, :payment_date, :profit, :payment_to_borrowed, :status_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
