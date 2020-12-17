class LoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan, only: [:show, :edit, :update, :destroy]

  # GET /loans
  # GET /loans.json
  def index
    @loans = Loan.all
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    #/////////////////////////////////////////////////////////
    #THIS IS NOT USED look into creditors_controller#new_loan
    #/////////////////////////////////////////////////////////
    #@loan = Loan.new
    #@new_user='papa con capsu'
  end

  # GET /loans/1/edit
  def edit
    render :show unless @can_user_edit
    @new_user = User.new()
  end

  # POST /loans
  # POST /loans.json
  def create
    param_newloan = loan_params

    #Rails.logger.info "LARANGEL: params: #{param_newloan.inspect}"
    @loan = Loan.new(param_newloan[:loan])
    
    render :index if @loan.moneylender.user_id !=  current_user.id  && !current_user.admin?

    @add_new_user = param_newloan[:add][:new_user]
    if ( @add_new_user == "true" )
      #We need to create a new user
      @new_user = User.new(param_newloan[:new_user]);
      @new_user.password = "mevale14"
      unless ( @new_user.save )
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @new_user.errors, status: :unprocessable_entity }
        end
        return
      end

      @loan.user_id = @new_user.id
    end
    
    respond_to do |format|
      if @loan.save
        format.html { redirect_to creditor_path(@loan.moneylender_id), notice: "El prestamos para #{@loan.user.complete_name} por #{@loan.amount_borrowed}, se ha creado exitosamente " }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    render :show unless @can_user_edit

    respond_to do |format|
      if @loan.update(loan_params[:loan])
        format.html { redirect_to creditor_path(@loan.moneylender_id), notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    render :show unless @can_user_edit
    
    moneylender_id = @loan.moneylender_id
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to creditor_path(moneylender_id), notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
      @can_user_edit = current_user.admin? || current_user.id == @loan.moneylender.user_id
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.permit(loan: [ :moneylender_id, :status_id, :loan_type_id, :amount_borrowed, :balance, :loan_date, :start_date, :next_payment_date, :next_amount_payment,:user_id ], new_user:[ :name, :lastname, :email ], add: [:new_user]  )
    end
end
