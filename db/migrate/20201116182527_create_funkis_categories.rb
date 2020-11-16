class CreateFunkisCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :funkis_categories do |t|
      t.string :title
      t.string :desc

      t.timestamps
    end
  end
end
