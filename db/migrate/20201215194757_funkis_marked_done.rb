class FunkisMarkedDone < ActiveRecord::Migration[5.0]
  def change
    add_column :funkis, :marked_done, :boolean, :default => false
  end
end
