class CreditorsController < ApplicationController
   before_action :authenticate_user!

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
         @moneylenders = Moneylender.where(user_id: current_user.id)
         @loans =  Loan.joins(:moneylender).where(moneylenders: { user_id: current_user.id }).order(:id)
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
         session[:filter_loan] = nil
         #render :index
         redirect_to :action => "list_all"
         return
      end
      
      session[:money_lender_id] = @moneylender.id
      session[:render_view_loans] = params['render_view_loans']  unless params['render_view_loans'].nil?
      session[:filter_loan] = params['filter'] if !params['filter'].nil? && params['filter'] != session[:filter_loan]

      @loans = Loan.joins(:moneylender).where(moneylender_id: params['id']).order(:id)
      # @loans.each { |l| 
      #       if l.updated_at.day != Date.today.day 
      #          l.recalculation
      #          l.save!
      #       end 
      #    }

      case session[:filter_loan]
         when "delayed"
            @loans = @moneylender.loan.delayed #.where("next_payment_date < ? and status_id=1", Time.now)
            @users = User.joins(:loans).merge(@loans).group('users.id') #  .where("loans.next_payment_date < ? and loans.status_id=1 and loans.moneylender_id=?",Time.now, params['id'] ).group('users.id').order('users.name')
         when "coming"
            @loans = @moneylender.loan.coming #.where("next_payment_date <= ? and next_payment_date > ? and status_id=1", Time.now + 2.day, Time.now)
            @users = User.joins(:loans).merge(@loans).group('users.id') #.where("loans.next_payment_date <= ? and next_payment_date > ? and loans.status_id=1 and loans.moneylender_id=?",Time.now + 2.day, Time.now, params['id'] ).group('users.id').order('users.name')
         when "aware"
            @loans = @moneylender.loan.ok #where("next_payment_date >= ? and status_id=1", Time.now)
            @users = User.joins(:loans).merge(@loans).group('users.id') #.where("loans.next_payment_date >= ? and loans.status_id=1 and loans.moneylender_id=?",Time.now, params['id'] ).group('users.id').order('users.name')
         when "paied"
            @loans = @moneylender.loan.paied #where(status_id: [2,3])
            @users = User.joins(:loans).merge(@loans).group('users.id') # .where(:loans => { status_id: [2,3], moneylender_id: params['id'] }).group('users.id').order('users.name')
         when "close"
            @loans = @moneylender.loan.closed #.where(status_id: [4,5])
            @users = User.joins(:loans).merge(@loans).group('users.id') #.where(:loans => { status_id: [4,5], moneylender_id: params['id']  }).group('users.id').order('users.name')
         else
            @loans = @moneylender.loan
            @users = User.joins(:loans).merge(@loans).group('users.id') #.where(:loans => { moneylender_id: params['id'] }).group('users.id').order('users.name')
      end

      #Rails.logger.info "LARANGEL [:render_view_loans]:#{session[:render_view_loans]}"
      #Rails.logger.info "LARANGEL users:#{@users.size}"
      #Rails.logger.info "LARANGEL loans:#{@loans.size}"

      respond_to do |format|
         @render_view_loans = session[:render_view_loans] == "table" ? "table" : "users"
         format.js {render "show_loans" }
         format.html { render "show" }
      end

   end

   # GET /creditors/:moneylender_id/only_buttons
   def only_buttons
      return if params['moneylender_id'].nil?
      @moneylender = Moneylender.find(params['moneylender_id'])
      respond_to do |format|
           format.html { render partial: "buttons_filter" }
           format.json { render partial: "buttons_filter", formats: "html", locals: { moneylender: @moneylender} }
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
      @loan.loan_date = Date.today
      @loan.start_date = Date.today
      @loan_types = LoanType.all
      Rails.logger.info "//////////////LARANGEL #{@loan_types.inspect}"
      render template: "loans/new" , locals: { loan: @loan }
   end

   # GET /creditors/:moneylender_id/user_loans/:user_id
   def user_loans
      @loans = Loan.where(user_id: params['user_id'], moneylender_id: params['moneylender_id'] )
      respond_to do |format| 
         format.json { render partial: "user_loans", formats: "html", locals: { loans: @loans} }
      end
   end

   # GET /creditors/:moneylender_id/weekly_payments/:year/:week
   def weekly_payments
      pparams = params.permit( :moneylender_id, :year, :week )
      @week_start = Date.commercial( pparams['year'].to_i, pparams['week'].to_i, 1 )
      @week_end   = Date.commercial( pparams['year'].to_i, pparams['week'].to_i, 7 )
      @moneylender = Moneylender.find(pparams['moneylender_id'])
      @loans = @moneylender.loan.where( "start_date <= ? and end_date >= ? and loans.status_id = 1", @week_start, @week_end )
      @payments_week = Payment.parents.joins(:loan).merge(@loans).where( "payment_date >= ? and payment_date <= ?", @week_start, @week_end )
      
      @total_a_pagar = @loans.sum(:next_amount_payment)
      @total_pagado  = @payments_week.sum(:payment_to_borrowed)

      respond_to do |format|
         #format.js {render template: "show_loans" }
         format.html { render  "weekly_payments" }
      end
   end

end
