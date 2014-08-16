/* Logger */
PageOne.Logger = {
  info: function(str) {
    if (PageOne.LOGGING) {
      Ember.Logger.info(str);
    }

    if (PageOne.PERSIST_LOG) {
      this._persist(str);
    }
  },
  error: function(str) {
    Ember.Logger.error(str);
  },
  time: function(timerName) {
    console.time(timerName);
  },
  timeEnd: function(timerName) {
    console.timeEnd(timerName);
  }
}
