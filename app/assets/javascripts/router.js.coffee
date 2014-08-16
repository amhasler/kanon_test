if Modernizr.history
  PageOne.Logger.info "HTML5 History API supported"
else
  PageOne.Logger.info "HTML5 History API not supported"


PageOne.Router.map ->