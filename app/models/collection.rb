class Collection < ActiveRecord::Base
	include FileAttachmentModule

  # ==== ASSOCIATIONS ====
  # All associations are destroyed when the timeline is destroyed
  has_many :items, dependent: :destroy
  belongs_to :author, class_name: "User", inverse_of: :collections, foreign_key: :author_id 
  
  # ==== VALIDATIONS ====
  validates_presence_of :author

  # ==== ATTACHMENTS ====
  # Thumb for the timeline
  mount_uploader :cover, CollectionCoverUploader
end
