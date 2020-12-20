class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :only_admins
  
  def index
  end

  def only_admins
     redirect_to :root unless current_user.admin?
  end
end
