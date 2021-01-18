class FunkAppModifyFKeys < ActiveRecord::Migration[5.0]
  def change
    remove_column :funkis_applications, :first_post
    remove_column :funkis_applications, :sec_post
    remove_column :funkis_applications, :third_post

    change_table :funkis_applications do |t|
      t.belongs_to :first_post
      t.belongs_to :second_post
      t.belongs_to :third_post
    end

  end
end
