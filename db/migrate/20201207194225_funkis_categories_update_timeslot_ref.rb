class FunkisCategoriesUpdateTimeslotRef < ActiveRecord::Migration[5.0]
  def change
    change_table :funkis_categories do |t|
      t.references :funkis_timeslots, foreign_key: true
    end
  end
end
