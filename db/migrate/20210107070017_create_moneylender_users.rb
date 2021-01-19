class CreateMoneylenderUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :moneylender_users do |t|
      t.belongs_to :moneylender, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
