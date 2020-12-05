class DashboardController < ApplicationController
   def home
      @loans = Loan.where("user_id = ?", current_user.id) #Open loans
   end
end
