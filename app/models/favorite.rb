class Favorite < ActiveRecord::Base
	belongs_to :artobject
	belongs_to :user
end