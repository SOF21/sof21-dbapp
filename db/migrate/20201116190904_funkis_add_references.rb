class FunkisAddReferences < ActiveRecord::Migration[5.0]
  def change
    change_table :funkis do |t|
      t.references :funkis_application, foreign_key: true
    end

    change_table :funkis_applications do |t|
      t.belongs_to :funkis
      t.integer :first_post, index: true, foreign_key: true
      t.integer :sec_post, index: true, foreign_key: true
      t.integer :third_post, index: true, foreign_key: true
    end

    change_table :funkis_categories do |t|
      t.references :funkis_timeslots
    end

    change_table :funkis_timeslots do |t|
      t.belongs_to :funkis_category
      t.belongs_to :funkis
    end
  end
end
