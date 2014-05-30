require 'file_size_validator' 

class Artobject < ActiveRecord::Base
	include MaxTagSize

	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :favorited, through: :favorites, source: :user
 
	mount_uploader :image, ImageUploader

	validates :name, presence: true, length: { maximum: 40 }
	validates :minyear, presence: true, length: { maximum: 5}
	default_scope -> { order('created_at DESC') }
	validates :image, 
		:file_size => { 
	    :maximum => 4.megabytes.to_i 
	}
	validate :max_tag_size
	validate :validate_min_date, :if => :minyear
	
	self.per_page = 14

	acts_as_taggable_on :creators, :locations, :languages, :societies, :mediums

	def self.search(query)
	  where("lower(name) LIKE ?", "%#{query.downcase}%") 
	end

	private

		def validate_min_date
		  errors.add("Work's year of origin", "must be at least 30 years in the past.") if (self.minyear - Time.now.year) > -30
		end
end
