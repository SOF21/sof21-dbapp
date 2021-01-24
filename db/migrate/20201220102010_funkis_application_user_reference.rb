class FunkisApplicationUserReference < ActiveRecord::Migration[5.0]
  def change
    change_table :funkis_applications do |t|
      t.belongs_to :user, index: true
    end
  end
end
