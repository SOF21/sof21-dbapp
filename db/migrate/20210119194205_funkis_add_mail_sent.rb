class FunkisAddMailSent < ActiveRecord::Migration[5.0]
  def change
    add_column :funkis, :booking_sent, :boolean, :default => false
  end
end
