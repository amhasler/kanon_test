module MaxTagSize
	extend ActiveSupport::Concern

  def max_tag_size
  	errors[:creator_list] << "Please limit to three tags per category" if creator_list.count > 3
		self.creator_list.each do |tag|
		  errors[:creator_list] << "Tag must be shorter than twenty characters" if tag.length > 20
		end
		errors[:society_list] << "Please limit to three tags per category" if society_list.count > 3
		self.creator_list.each do |tag|
		  errors[:society_list] << "Tag must be shorter than twenty characters" if tag.length > 20
		end
		errors[:location_list] << "Please limit to three tags per category" if creator_list.count > 3
		self.creator_list.each do |tag|
		  errors[:location_list] << "Tag must be shorter than twenty characters" if tag.length > 20
		end
		errors[:language_list] << "Please limit to three tags per category" if creator_list.count > 3
		self.creator_list.each do |tag|
		  errors[:language_list] << "Tag must be shorter than twenty characters" if tag.length > 20
		end
		errors[:medium_list] << "Please limit to three tags per category" if creator_list.count > 3
		self.creator_list.each do |tag|
		  errors[:creator_list] << "Tag must be shorter than twenty characters" if tag.length > 20
		end
	end
end