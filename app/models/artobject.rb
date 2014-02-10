class Artobject < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 40 }
	default_scope -> { order('created_at DESC') }

end
