class CreateFunkis < ActiveRecord::Migration[5.0]
  def change
    create_table :funkis do |t|
      t.string :name
      t.string :liu_id
      t.string :liu_card
      t.string :mail
      t.string :phone_number
      t.string :post_address
      t.string :association
      t.string :tshirt_size
      t.string :allergies
      t.string :allergies_other
      t.string :share_info
      t.boolean :gdpr

      t.timestamps
    end
  end
end
