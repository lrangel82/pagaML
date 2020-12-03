class CreditorsController < ApplicationController
   #before_action :authenticate_admin!

   #GET creditors/index
   def index
      init_creditors
      #@moneylenders = Moneylender.find_by(user_id: current_user.id)
      #@total_amount_borrowed ||= Loan.joins(:moneylender).where(moneylenders: { user: current_user }).sum(:amount_borrowed)
   end

   def show
      @moneylender = Moneylender.find(params['id'])
      @loans = Loan.joins(:moneylender).where(moneylender_id: params['id']).order(:id)
      @loans.each { |l| l.recal }
   end

   # GET /new_loan/$money_lender_id
   def new_loan
      render :index if params['money_lender_id'].nil?

      @moneylender =  Moneylender.find( params['money_lender_id'] )
      @loan =  @moneylender.loan.build
      #@new_user = { add_new_user: "false", name: nil, lastnme: nil, email: nil }
      @new_user = User.new
      @add_new_user = false
      render template: "loans/new" , locals: { loan: @loan }
   end

private
   def init_creditors
      #return if user_signed_in?
      if ( current_user.admin? )
         @moneylenders = Moneylender.all
         @loans = Loan.all.order(:id)
      else
         @moneylenders = Moneylender.where(user: current_user)
         @loans = Loan.joins(:moneylender).where(moneylenders: { user: current_user }).order(:id)
      end
      @loans_count ||= @loans.count
      @total_amount_borrowed ||= @loans.sum(:amount_borrowed)
      @total_balance ||= @loans.sum(:balance)
      @total_next_amount_payment = @loans.sum(&:next_amount_payment)
      @total_profit ||= @loans.sum{ |l| l.payments.sum(:profit) }
   end


end
