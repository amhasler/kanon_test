module ArtobjectsHelper
	def date_maker(artobject)
		date = stringify_absolute_bce(artobject.minyear)
		if artobject.maxyear
			date = "Between " + date + " and " + stringify_absolute_bce(artobject.maxyear)
		end
		return date
	end

	def stringify_absolute_bce(year)
		new_year = "#{year.abs}"
		if year < 0
			new_year = new_year + " BCE"
		end
		return new_year
	end

	def tag_mix(artobject)
		tag_list = artobject.creator_list.map { |t| link_to t, artobjects_path(params.merge(:tags => t)), class: "creator-list-tag" } + artobject.location_list.map { |t| link_to t, artobjects_path(params.merge(:tags => t)), class: "location-list-tag" } + artobject.language_list.map { |t| link_to t, artobjects_path(params.merge(:tags => t)), class: "language-list-tag" } + artobject.medium_list.map { |t| link_to t, artobjects_path(params.merge(:tags => t)), class: "creator-list-tag" } + artobject.society_list.map { |t| link_to t, artobjects_path(params.merge(:tags => t)), class: "creator-list-tag" }
		return tag_list.join(' ')
	end
end
