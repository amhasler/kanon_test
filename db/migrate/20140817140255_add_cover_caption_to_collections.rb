class AddCoverCaptionToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :cover_caption, :text
  end
end
