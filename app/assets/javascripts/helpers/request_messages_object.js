/* Converts a JSON error response for a request into an Ember error object. */
PageOne.RequestMessagesObject = Ember.Object.extend({
  /* Must provide two arguments at creation:
   * - json
   * - type ("errors" or "successes")
   */
  _init: function() {
    // this._super();

    var self = this;

    var messages_json = this.get("json");
    
    // Highlighting
    PageOne.$.each(
      this.get('highlight'),
      function(index, value) {
        self.set(value, []);
      }
    );

    // Actual messages
    var type = "";
    if (this.get("type") == "success") {
      type = "successes";
    } else if (this.get("type") == "error") {
      type = "errors";
    }

    messages_json[type].forEach(function(error_obj) {
      self.set(error_obj.field, error_obj.messages);
    });
    // HstryEd.$.each(
    //   messages_json[type],
    //   function(index, value) {
    //     self.set(value.field, value.messages);
    //   }
    // );
  }.on('init'),
  highlight: []
});
