if Modernizr.history
  PageOne.Logger.info "HTML5 History API supported"
else
  PageOne.Logger.info "HTML5 History API not supported"

#PageOne.Router.reopen
#  location: 'auto'

PageOne.Router.map ->
	@resource 'collection', { path: '/collections/:collection_id' }