class UserSerializer < ActiveModel::Serializer
	attribute     :id
  attribute     :email
  attribute     :name
  attribute     :name
  attribute     :image

  # ==== ASSOCIATIONS ====
  has_many      :collections, include: true, embed: :ids, key: :collections

  def image
    return Image.new(object[:image], object.image.full.url, object.image.thumb.url, object.image_caption) if object.image?
    nil
  end

end
  