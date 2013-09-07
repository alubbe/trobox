class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :box_file_path
      t.integer :document_type
      t.integer :user_id
      t.timestamps
    end
  end
end
