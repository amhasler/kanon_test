class AddImageToArtobjects < ActiveRecord::Migration
  def change
    add_column :artobjects, :image, :string
  end
end
