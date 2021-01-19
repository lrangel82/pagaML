class AddInitialMoneylenderUsers < ActiveRecord::Migration[6.0]
  def change

    #Populet the table
    Moneylender.joins(:loan).select("moneylenders.id","loans.user_id").group("moneylenders.id","loans.user_id").each do |ml_user|
      MoneylenderUser.create(moneylender_id: ml_user.id, user_id: ml_user.user_id)
    end

  end
end
