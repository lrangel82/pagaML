class Payment < ApplicationRecord
  belongs_to :loan
  belongs_to :status

  validates :amount,:payment_date,:profit,:payment_to_borrowed,:status_id, presence: true
 
end
