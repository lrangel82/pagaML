class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :only_admins
  
  def index
  end

  def only_admins
     redirect_to :root unless current_user.admin?
  end

  def export_payments
    send_data  Payment.to_csv, :type => 'text/csv; charset=utf-8; header=present', :disposition => 'attachment; filename=payments.csv'
  end

  def export_loans
    send_data  Loan.to_csv, :type => 'text/csv; charset=utf-8; header=present', :disposition => 'attachment; filename=loans.csv'
  end
end
