class CreditorsController < ApplicationController
   before_action :authenticate_admin!

   #GET creditors/index
   def index
      if !session[:money_lender_id].nil? && session[:money_lender_id] > 0
         redirect_to creditor_path(session[:money_lender_id])
      else
         redirect_to :action => "list_all"
      end
   end

   def list_all
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

      render "creditors/index"
   end

   def show
      render :index if params['id'].nil?
      @moneylender = Moneylender.find(params['id'])

      if @moneylender.user != current_user && !current_user.admin?
         session[:money_lender_id] = nil
         session[:render_view_loans] = nil
         render :index
         return
      end
      session[:money_lender_id] = @moneylender.id
      session[:render_view_loans] = params['render_view_loans']  if params['render_view_loans'].nil?

      @loans = Loan.joins(:moneylender).where(moneylender_id: params['id']).order(:id)
      @loans.each { |l| l.recal if l.updated_at.day != Date.today.day }

      if !session[:render_view_loans].nil? && session[:render_view_loans] == "table"
         render partial: "show_table"
      else
         @users = User.joins(:loans).where(:loans => { moneylender_id: params['id'] }).group('users.id')
         render "show"
      end
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

   # GET /creditors/:moneylender_id/user_loans/:user_id
   def user_loans
      @loans = Loan.where(user_id: params['user_id'], moneylender_id: params['moneylender_id'] )
      respond_to do |format| 
         format.json { render partial: "user_loans", formats: "html", locals: { loans: @loans} }
      end
   end

end
