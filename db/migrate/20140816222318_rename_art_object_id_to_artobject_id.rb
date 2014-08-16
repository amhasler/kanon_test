class RenameArtObjectIdToArtobjectId < ActiveRecord::Migration
  def change
  	rename_column :items, :art_object_id, :artobject_id
  end
end
