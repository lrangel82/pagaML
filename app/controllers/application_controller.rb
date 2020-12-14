class ApplicationController < ActionController::Base
   around_action :switch_locale
   before_action :authenticate_user!

   def authenticate_admin!
      redirect_to root_path  unless current_user.admin?
      return true
   end

   def after_sign_in_path_for(resource)
     if current_user.admin?
        creditors_path
     elsif current_user.moneylender.any?
        creditors_path(current_user.moneylender.first.id) # your path
     else
        root_path
     end
   end

   def switch_locale(&action)
     #Rails.logger.info "LARANGEL  Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
     locale = extract_locale_from_accept_language_header
     #Rails.logger.info "LARANGEL  Locale set to '#{locale}'"
     I18n.with_locale(locale, &action)
  end

  private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
