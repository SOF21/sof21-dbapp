class RemoveStudentAssociationFromCortege < ActiveRecord::Migration[5.0]
  def change
    remove_column :corteges, :student_association, :string
  end
end
