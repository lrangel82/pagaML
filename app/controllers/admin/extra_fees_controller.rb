class Admin::ExtraFeesController < ApplicationController
  before_action :set_extra_fee, only: [:show, :edit, :update, :destroy]

  # GET /extra_fees
  # GET /extra_fees.json
  def index
    @extra_fees = ExtraFee.all
  end

  # GET /extra_fees/1
  # GET /extra_fees/1.json
  def show
  end

  # GET /extra_fees/new
  def new
    @extra_fee = ExtraFee.new
  end

  # GET /extra_fees/1/edit
  def edit
  end

  # POST /extra_fees
  # POST /extra_fees.json
  def create
    @extra_fee = ExtraFee.new(extra_fee_params)

    respond_to do |format|
      if @extra_fee.save
        format.html { redirect_to admin_extra_fees_path(@extra_fee), notice: 'Extra fee was successfully created.' }
        format.json { render :show, status: :created, location: @extra_fee }
      else
        format.html { render :new }
        format.json { render json: @extra_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extra_fees/1
  # PATCH/PUT /extra_fees/1.json
  def update
    respond_to do |format|
      if @extra_fee.update(extra_fee_params)
        format.html { redirect_to admin_extra_fees_path(@extra_fee), notice: 'Extra fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @extra_fee }
      else
        format.html { render :edit }
        format.json { render json: @extra_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extra_fees/1
  # DELETE /extra_fees/1.json
  def destroy
    @extra_fee.destroy
    respond_to do |format|
      format.html { redirect_to admin_extra_fees_url, notice: 'Extra fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extra_fee
      @extra_fee = ExtraFee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def extra_fee_params
      params.require(:extra_fee).permit(:loan_id, :late_fee, :late_fee_profit, :old_balance, :new_balance)
    end
end
