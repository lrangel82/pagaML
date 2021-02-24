class UpdatePaymentsOpenToPaied < ActiveRecord::Migration[6.0]
  def change
      Payment.where(:status_id => 1).update( :status_id => 2)
  end
end
