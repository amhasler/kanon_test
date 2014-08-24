Ember.TextField.reopen({
  attributeBindings: ['required'],
  // From http://stackoverflow.com/a/23228950/1269194. For autocomplete on Firefox.
  fixAutofillBug: function () {
    // The 200 is kind of random, the autofill-event polyfill uses the same value (see https://github.com/tbosch/autofill-event/blob/master/src/autofill-event.js)
    Ember.run.later(this, function() {
      if (this.$()) {
        this.$().trigger('change');
      }
    }, 200);
  }.on('didInsertElement'),
});

PageOne.FieldView = Ember.View.extend({
  classNames: ['input-field'],
  classNameBindings: ['errors:error', 'name'],
  templateName: 'helpers/form_field',
  /* Callbacks */
  didInsertElement: function() {
    this._doFocus();
  },
  /* Helpers */
  _doFocus: function() {
    if (this.get('doFocus')) {
      this.$("input").focus();
      this.set('doFocus', false);
    }
  },
  /* Observers */
  onDoFocus: function() {
    // If it's been added to the DOM
    if (this.$()) {
      this._doFocus();
    }
  }.observes('doFocus'),
});

PageOne.TextareaView = Ember.View.extend({
  classNames: ['input-field'],
  classNameBindings: ['errors:error', 'name'],
  templateName: 'helpers/form_textarea'
});
