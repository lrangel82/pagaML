class PaymentsController < ApplicationController
  before_action :get_laon
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET loans/$loan_id/payments
  # GET loans/$loan_id/payments.json
  def index
    @payments = @loan.payments # Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = @loan.payments.build #Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = @loan.payments.build(payment_params) #Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to loan_payments_path(@loan), notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to loan_path(@loan), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to loan_path(@loan), notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_laon
      @loan = Loan.find(params[:loan_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = @loan.payments.find(params[:id]) #Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:loan_id, :amount, :payment_date, :profit, :payment_to_borrowed, :status_id)
    end
end
