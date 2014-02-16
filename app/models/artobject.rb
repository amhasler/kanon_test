class Artobject < ActiveRecord::Base
	belongs_to :user
	validates :name, presence: true, length: { maximum: 40 }
	validates :minyear, presence: true, length: { maximum: 5}
	default_scope -> { order('created_at DESC') }
end
