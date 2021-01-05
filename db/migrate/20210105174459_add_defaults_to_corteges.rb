class AddDefaultsToCorteges < ActiveRecord::Migration[5.0]
  def change
    change_column_default :corteges, :feedback,""
    change_column_default :corteges, :security_feedback, ""
    change_column_default :corteges, :other_comments, ""
  end
end
