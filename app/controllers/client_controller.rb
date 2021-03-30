class ClientController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client_loans, only: [:show, :edit, :update, :destroy]
  
  def index
  end

  # GET show/:user_id
  def show
  end

  def search
    @users = User.search(params[:term])
    render json: @users.map{ |x| ({ id: x.id, value: x.name}) }
  end


 private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_loans
      
      @client = User.find(params[:id])
      Rails.logger.info "/////////////LARANGEL client:#{@client}"
      if current_user.admin?
         @loans = Loan.where(user_id: @client.id)
      else
         moneylender_id = session[:money_lender_id] || Moneylender.find(user_id: current_user.id).id
         @loans = Loan.where(user_id: @client.id, moneylender_id: moneylender_id)
      end
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.permit(loan: [ :moneylender_id, :status_id, :amount_borrowed, :balance, :loan_date, :start_date, :next_payment_date, :next_amount_payment,:user_id,:payment_frequency_days,:is_profit_balane,:number_of_payments,:profit_by_payment,:description ], new_user:[ :name, :lastname, :email ], add: [:new_user]  )
    end
end
