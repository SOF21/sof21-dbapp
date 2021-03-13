class AddFeebackToCortege < ActiveRecord::Migration[5.0]
  def change
    add_column :corteges, :feedback, :string, null:false
    add_column :corteges, :security_feedback, :string, null:false
    add_column :corteges, :info_mail, :boolean, default: false, null:false
    add_column :corteges, :electricity, :boolean, default: false, null:false
    add_column :corteges, :other_comments, :string, null:false
  end
end
