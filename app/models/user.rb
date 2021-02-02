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
    #moneylender.size > 0
    Moneylender.where(user_id: id ).size > 0
  end

  def complete_name
    (name + ' ' + lastname).strip
  end

  def ok?(money_lender_id)
    loans.where(moneylender_id: money_lender_id, status_id: 1).each { |l| return false unless l.ok? }
    #loans.where("next_payment_date >= ? and loans.status_id=1 and loans.moneylender_id=?",Time.now, money_lender_id )
    return true
  end
  def coming?(money_lender_id)
    loans.where(moneylender_id: money_lender_id, status_id: 1).each { |l| return true if l.coming? }
    return false
  end

  def delayed?(money_lender_id)
    loans.where(moneylender_id: money_lender_id).each { |l| return true if l.delayed? }
    return false
  end

  def paied?(money_lender_id)
    loans.where(moneylender_id: money_lender_id).each { |l| return false unless l.paied? }
    return true
  end
  def closed?(money_lender_id)
    loans.where(moneylender_id: money_lender_id).each { |l| return true if l.closed? }
    return false
  end

  def self.search(term)
    where("name ILIKE ? or email ILIKE ?", "%#{term}%", "%#{term}%")
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
