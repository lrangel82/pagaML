class Moneylender < ApplicationRecord
   has_many :loan
   belongs_to :user

   def loans_delayed
      @loans_delayed ||= loan.delayed.count
   end
   def loans_coming
      @loans_coming ||= loan.coming.count
   end
   def loans_ok
      @loans_ok ||= loan.ok.count
   end
   def loans_paied
      @loans_paied ||= loan.paied.count
   end
   def loans_closed
      @loans_closed ||= loan.closed.count
   end
end
