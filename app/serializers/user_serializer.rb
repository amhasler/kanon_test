class UserSerializer < ActiveModel::Serializer
	attribute     :id
  attribute     :email
  attribute     :name
  attribute     :name
  attribute     :image

  # ==== ASSOCIATIONS ====
  has_many      :collections, embed: :ids, key: :collections

  def image
    return Image.new(object[:image], object.image.full.url, object.image.thumb.url) if object.image?
    nil
  end

end
  