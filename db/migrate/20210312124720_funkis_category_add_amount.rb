class FunkisCategoryAddAmount < ActiveRecord::Migration[5.0]
  def change
    add_column :funkis_categories, :amount_needed, :integer, default: 0
  end
end
