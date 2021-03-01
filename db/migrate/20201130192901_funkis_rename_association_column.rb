class FunkisRenameAssociationColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :funkis, :association, :association_name
  end
end
