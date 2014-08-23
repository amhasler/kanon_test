class ArtobjectSerializer < ActiveModel::Serializer
  self.root = true
  
  # ==== ATTRIBUTES ====
  attribute :id
  attribute :name
  attribute :day
  attribute :month
  attribute :year
  attribute :minday
  attribute :minmonth
  attribute :minyear
  attribute :maxday
  attribute :maxmonth
  attribute :maxyear
  attribute :approximatedate
  attribute :image

  def image
    return Image.new(object[:image], object.image.full.url, object.image.thumb.url) if object.image?
    nil
  end

  has_one   :user, embed: :id, key: :user
end

