class FunkisApplicationAddWorkfriendId < ActiveRecord::Migration[5.0]
  def change
    add_column :funkis_applications, :workfriend_id, :string
  end
end
