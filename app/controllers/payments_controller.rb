class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_loan
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET loans/$loan_id/payments
  # GET loans/$loan_id/payments.json
  def index
    @payments = @loan.payments # Payment.all
  end

  # GET loans/$loan_id/payments/1
  # GET loans/$loan_id/payments/1.json
  def show
  end

  # GET loans/$loan_id/payments/new
  def new
    @payment = @loan.payments.build #Payment.new
    @payment.parent_id = params[:parent_id]
    @payment.payment_date = Date.today
    if @payment.parent_id.nil?
      @payment.amount = @loan.next_amount_payment.round(2)
      @payment.profit = @loan.recal_profit(  @payment.amount ).round(2)
      @payment.payment_to_borrowed = @loan.recal_payment_to_borroewd(  @payment.amount ).round(2)
    else
      @payment.amount = @loan.next_amount_payment.round(2) - Payment.find(@payment.parent_id).amount
      @payment.profit = 0
      @payment.payment_to_borrowed = 0
    end
    respond_to do |format|
      format.html { render "new" }
      format.json { render partial: "form", formats: "html", locals: { payment: @payment , backpath: "#"} }
    end
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
        #the payment is parent
        if @payment.parent_id.nil?
          #And less of minimun, we need to create a child 
          if @payment.amount < @loan.next_amount_payment
              @payment_child = @loan.payments.build(payment_params) #Payment.new(payment_params)
              @payment_child.profit = 0
              @payment_child.parent_id = @payment.id
              @payment_child.save
          end
        else
          #we need to update the parent
          p = @payment.parent
          p.amount += @payment.amount
          p.profit = @loan.recal_profit( p.amount ).round(2)
          p.payment_to_borrowed = @loan.recal_payment_to_borroewd( p.amount ).round(2)
          p.save!
        end
        @loan.save!
        format.js   { render "dialog_from_creditors" } if request.referrer.include?(creditors_path)
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
        unless @payment.parent_id.nil?
          #we need to update the parent
          p = @payment.parent
          p.amount = p.children.sum(:amount)
          p.profit = @loan.recal_profit( p.amount ).round(2)
          p.payment_to_borrowed = @loan.recal_payment_to_borroewd( p.amount ).round(2)
          p.save!
        end
        @loan.save!
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
    is_child = ! @payment.parent_id.nil?
    p = @payment.parent

    @payment.destroy
    if is_child
      #we need to update the parent
      p.amount = p.children.sum(:amount)
      p.profit = @loan.recal_profit( p.amount ).round(2)
      p.payment_to_borrowed = @loan.recal_payment_to_borroewd( p.amount ).round(2)
      p.save!
    end
    @loan.save!
    respond_to do |format|
      format.html { redirect_to loan_path(@loan), notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_loan
      @loan = Loan.find(params[:loan_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = @loan.payments.find(params[:id]) #Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:loan_id, :parent_id, :amount, :payment_date, :profit, :payment_to_borrowed, :status_id)
    end
end
