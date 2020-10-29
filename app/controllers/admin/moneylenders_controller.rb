class Admin::MoneylendersController < ApplicationController
  before_action :set_moneylender, only: [:show, :edit, :update, :destroy]

  # GET /moneylenders
  # GET /moneylenders.json
  def index
    @moneylenders = Moneylender.all
  end

  # GET /moneylenders/1
  # GET /moneylenders/1.json
  def show
  end

  # GET /moneylenders/new
  def new
    @moneylender = Moneylender.new
  end

  # GET /moneylenders/1/edit
  def edit
  end

  # POST /moneylenders
  # POST /moneylenders.json
  def create
    @moneylender = Moneylender.new(moneylender_params)

    respond_to do |format|
      if @moneylender.save
        format.html { redirect_to admin_moneylender_path(@moneylender), notice: 'Moneylender was successfully created.' }
        format.json { render :show, status: :created, location: @moneylender }
      else
        format.html { render :new }
        format.json { render json: @moneylender.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moneylenders/1
  # PATCH/PUT /moneylenders/1.json
  def update
    respond_to do |format|
      if @moneylender.update(moneylender_params)
        format.html { redirect_to admin_moneylender_path(@moneylender), notice: 'Moneylender was successfully updated.' }
        format.json { render :show, status: :ok, location: @moneylender }
      else
        format.html { render :edit }
        format.json { render json: @moneylender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moneylenders/1
  # DELETE /moneylenders/1.json
  def destroy
    @moneylender.destroy
    respond_to do |format|
      format.html { redirect_to admin_moneylenders_url, notice: 'Moneylender was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moneylender
      @moneylender = Moneylender.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def moneylender_params
      params.require(:moneylender).permit(:alias, :clabe, :account_number, :bank)
    end
end
