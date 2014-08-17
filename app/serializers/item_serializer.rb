class ItemSerializer < ActiveModel::Serializer
  
  attribute   :id
  attribute   :content
  attribute   :position

  has_one   :collection, embed: :id, key: :collection
  has_one   :artobject, embed: :id, include: true, key: :artobject

end
