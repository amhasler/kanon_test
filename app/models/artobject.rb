require 'file_size_validator' 

class Artobject < ActiveRecord::Base
	belongs_to :user
	mount_uploader :image, ImageUploader
	validates :name, presence: true, length: { maximum: 40 }
	validates :minyear, presence: true, length: { maximum: 5}
	default_scope -> { order('created_at DESC') }
	validates :image, 
		:file_size => { 
	    :maximum => 4.megabytes.to_i 
	}
end
