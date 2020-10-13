class AddUserToMoneylender < ActiveRecord::Migration[6.0]
  def change
    add_reference :moneylenders, :user, null: false, foreign_key: true
  end
end
