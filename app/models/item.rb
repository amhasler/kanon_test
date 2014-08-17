class Item < ActiveRecord::Base
	default_scope { order(:position).includes(:collection) }

  # ==== ASSOCIATIONS ====
  belongs_to    :collection
  acts_as_list  scope: :collection
  # belongs_to    :artobject, dependent: :destroy

  # ==== VALIDATIONS ====
  validates_presence_of :collection
end
