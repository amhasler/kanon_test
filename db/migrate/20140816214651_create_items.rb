class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :content
      t.integer :collection_id
      t.integer :art_object_id

      t.timestamps
    end
  end
end
