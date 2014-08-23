class CollectionSerializer < ActiveModel::Serializer
  self.root = true

  # ==== ATTRIBUTES ====
  attributes  :id, :title, :introduction_content, :cover 

  # ==== ASSOCIATIONS ====
  has_one   :user, embed: :id, include: true, key: :user
  attribute :links
  attribute :cover

  def cover
    return Image.new(object[:cover], object.cover.url, object.cover.thumb.url) if object.cover?
    nil
  end

  def links
    {
      items: items_path(collection_id: object.id)
    }
  end


end

