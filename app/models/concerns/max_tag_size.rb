module MaxTagSize
	extend ActiveSupport::Concern

  def max_tag_size
  	errors[:creator_list] << "should have no more than three tags" if creator_list.count > 3
		self.creator_list.each do |tag|
		  errors[:creator_list] << "Tag must be shorter than forty characters" if tag.length > 40
		end
		errors[:society_list] << "should have no more than three tags" if society_list.count > 3
		self.creator_list.each do |tag|
		  errors[:society_list] << "Tag must be shorter than forty characters" if tag.length > 40
		end
		errors[:location_list] << "should have no more than three tags" if location_list.count > 3
		self.creator_list.each do |tag|
		  errors[:location_list] << "Tag must be shorter than forty characters" if tag.length > 40
		end
		errors[:language_list] << "should have no more than three tags" if language_list.count > 3
		self.creator_list.each do |tag|
		  errors[:language_list] << "Tag must be shorter than forty characters" if tag.length > 40
		end
		errors[:medium_list] << "should have no more than three tags" if medium_list.count > 3
		self.creator_list.each do |tag|
		  errors[:creator_list] << "Tag must be shorter than forty characters" if tag.length > 40
		end
	end
end