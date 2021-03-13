class RemoveUserIdFromFunkisApplication < ActiveRecord::Migration[5.0]
  def change
    remove_column :funkis_applications, :user_id, :string
    change_table :funkis_applications do |t|
      t.belongs_to :user, index: true
    end
  end
end
