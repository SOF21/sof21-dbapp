class RemoveDefaultFromOrchestra < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orchestras, :orchestra_type, nil
  end
end
