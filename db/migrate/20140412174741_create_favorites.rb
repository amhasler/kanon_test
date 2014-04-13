class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :artobject_id

      t.timestamps
    end

    add_index :favorites, :user_id
    add_index :favorites, :artobject_id
    add_index :favorites, [:user_id, :artobject_id], unique: true
  end
end
