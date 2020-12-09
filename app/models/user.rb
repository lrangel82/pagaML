class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :timeoutable, :lockable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  has_many :loans
  has_many :moneylender

  def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0, 20]
       #user.name = auth.info.name   # assuming the user model has a name
       #user.image = auth.info.image # assuming the user model has an image
       # If you are using confirmable and the provider(s) you use validate emails, 
       # uncomment the line below to skip the confirmation emails.
       #user.skip_confirmation!
     end
  end

  def monylender?
    moneylender.size > 0
  end

  def complete_name
    (name + ' ' + lastname).strip
  end

  def ok?
    loans.each { |l| return false unless l.ok? }
    return true
  end

  def delayed?
    loans.each { |l| return true if l.delayed? }
    return false
  end

  def paied?
    loans.each { |l| return false unless l.paied? }
    return true
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
