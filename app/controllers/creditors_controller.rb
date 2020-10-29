class CreditorsController < ApplicationController
   #before_action :authenticate_admin!

   #GET creditors/index
   def index
      init_creditors
      #@moneylenders = Moneylender.find_by(user_id: current_user.id)
      #@total_amount_borrowed ||= Loan.joins(:moneylender).where(moneylenders: { user: current_user }).sum(:amount_borrowed)
   end

   def show
      Rails.logger.info "LARANGEL #{params}"
      @moneylender = Moneylender.find(params['id'])
      @loans = Loan.joins(:moneylender).where(moneylender_id: params['id'])
   end

private
   def init_creditors
      #return if user_signed_in?
      if ( current_user.admin? )
         @moneylenders = Moneylender.all
         @loans = Loan.all
      else
         @moneylenders = Moneylender.where(user: current_user)
         @loans = Loan.joins(:moneylender).where(moneylenders: { user: current_user })
      end
      @loans_count ||= @loans.count
      @total_amount_borrowed ||= @loans.sum(:amount_borrowed)
      @total_balance ||= @loans.sum(:balance)
      @total_next_amount_payment = @loans.sum(&:next_amount_payment)
      @total_profit ||= @loans.sum{ |l| l.payments.sum(:profit) }
   end


end
