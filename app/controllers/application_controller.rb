class ApplicationController < ActionController::Base
   before_action :authenticate_user!

   def authenticate_admin!
      redirect_to root_path  unless current_user.admin?
      return true
   end
end
