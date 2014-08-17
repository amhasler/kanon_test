class CollectionSerializer < ActiveModel::Serializer
  self.root = true

  # ==== ATTRIBUTES ====
  attributes  :id, :title, :introduction_content, :cover 

  # ==== ASSOCIATIONS ====
  has_one   :user, embed: :id, key: :user
  has_many  :items, include: true, embed: :ids, key: :items

  def cover
    return Image.new(object[:cover], object.cover.url, object.cover.thumb.url) if object.cover?
    nil
  end


end

