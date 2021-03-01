class AddCheckedInToFunkis < ActiveRecord::Migration[5.0]
  def change
    add_column :funkis, :checked_in, :boolean, default: false
  end
end
