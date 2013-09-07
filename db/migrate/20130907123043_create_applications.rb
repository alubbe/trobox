class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :immo_id
      t.integer :user_id
      t.string :title
      t.string :picture_url
      t.string :price
      t.float :living_space
      t.float :rooms
      t.string :address
      t.string :city
      t.string :email
      t.string :mobile
      t.string :landline
      t.boolean :applied

      t.timestamps
    end
  end
end
