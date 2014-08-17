class ChangeAuthorIdToUserIdInCollections < ActiveRecord::Migration
  def change
  	rename_column :collections, :author_id, :user_id
  end
end
