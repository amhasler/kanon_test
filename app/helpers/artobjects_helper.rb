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

end
