class DashboardController < ApplicationController
   def home
      @loans = Loan.where("user_id = ? AND status_id = ?", current_user.id, 1) #Open loans
   end
end
