class UpdateLoansEndDate < ActiveRecord::Migration[6.0]
  def change
      Loan.all.each do |l|
         l.end_date = l.recal_end_date
         l.save
      end
  end
end
