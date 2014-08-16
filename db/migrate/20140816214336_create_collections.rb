class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title
      t.string :cover
      t.text :introduction_content
      t.integer :author_id

      t.timestamps
    end
  end
end
