class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.string :name, limit: 50

      t.timestamps
    end
  end
end
