class ClientController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def search
    @users = User.search(params[:term])
    render json: @users.map{ |x| ({ id: x.id, value: x.name}) }
  end
end
