class Moneylender < ApplicationRecord
   has_many :loan
   belongs_to :user

   def loans_delayed
      @loans_delayed ||= loan.where( "next_payment_date < ? and status_id=1", Date.today).count
   end
   def loans_coming
      @loans_coming ||= loan.where( "next_payment_date <= ? and next_payment_date > ? and status_id=1", Date.today + 2.day, Date.today).count
   end
   def loans_ok
      @loans_ok ||= loan.where( "next_payment_date >= ? and status_id=1", Date.today).count
   end
   def loans_paied
      @loans_paied ||= loan.where(status_id: [2,3]).count
   end
   def loans_closed
      @loans_closed ||= loan.where(status_id: [4,5]).count
   end
end
