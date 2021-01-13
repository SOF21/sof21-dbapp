class FunkisAddCategory < ActiveRecord::Migration[5.0]
  def change
    change_table :funkis do |t|
      t.references :funkis_category, foreign_key: true
    end
  end
end
