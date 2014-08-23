/* Transforms a time in milliseconds into 'mm:ss' format */
Ember.Handlebars.registerBoundHelper('dateMaker', function(artobject, options) {
  date = stringify_absolute_bce(artobject.get('minyear'))

  //if (! Ember.isNone(artobject.maxyear)) {
  //  date = "Between " + date + " and " + stringify_absolute_bce(artobject.get('maxyear'));
  //}

	return new Handlebars.SafeString("<span class='datemaker-date'>" + date + "</span>");

  function stringify_absolute_bce(year) {
		new_year = Math.abs(year).toString();
		if (year < 0) {
			new_year = new_year + " BCE";
		} else {
			new_year = new_year + " CE";
		}
		return new_year;
	}
});

/*
def date_maker(artobject)
		
		
		return date
	end

*/