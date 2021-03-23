class AddRowToStatus < ActiveRecord::Migration[6.0]
  def change
   Status.create(id: 7, name: "Due")
  end
end
