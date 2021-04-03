class ClientMailer < ApplicationMailer

   def send_invitation
      @user = params[:user]
      @url = "http://localhost:3000"
      mail(to: @user.email, subject: 'Bienvenido a pagaML')
   end
end
