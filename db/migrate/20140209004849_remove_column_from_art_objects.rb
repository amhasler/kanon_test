class RemoveColumnFromArtObjects < ActiveRecord::Migration
  def change
    remove_column :artobjects, :editors, :string
  end
end
