class Collection < ActiveRecord::Base
	include FileAttachmentModule

  # ==== ASSOCIATIONS ====
  # All associations are destroyed when the timeline is destroyed
  has_many :items, dependent: :destroy
  belongs_to :user
  
  # ==== VALIDATIONS ====
  validates_presence_of :user

  # ==== ATTACHMENTS ====
  # Thumb for the timeline
  mount_uploader :cover, CollectionCoverUploader
end
