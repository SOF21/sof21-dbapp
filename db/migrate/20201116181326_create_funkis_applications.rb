class CreateFunkisApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :funkis_applications do |t|

      t.datetime :first_day
      t.datetime :second_day
      t.datetime :third_day
      t.string :workfriend

      t.timestamps
    end
  end
end
