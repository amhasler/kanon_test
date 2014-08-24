/* Inplace editor. Takes arguments:
 * - model: Model. Required.
 * - text: Attribute of the model that we're editing. Required.
 * - placeholder: The placeholder to put when `text` is empty
 * - errors: array containing errors for this field
 * - doFocus: if true, will autofocus when initialized.
 */
PageOne.InplaceEditorComponent = Ember.Component.extend({
  classNames: ['inplace-editor'],
  classNameBindings: ['isEditing', 'name', 'errors:error'],
  /* Properties */
  placeholder: "Change the title",
  name: "",
  hasTextChanged: function() {
    return this.get('model.isDirty') && this.get('oldText') != this.get('text');
  }.property('model.isDirty', 'oldText', 'text').readOnly(),
  _resizeTextarea: function() {
    Ember.run.scheduleOnce('afterRender', this, function() {
      this.$('textarea').trigger('autosize.resize');
    });
  },
  /* Actions */
  actions: {
    edit: function() {
      this.set('isEditing', true);
      this.set('oldText', this.get('text'));

      this._resizeTextarea();
    },
    acceptChanges: function() {
      this.set('isEditing', false);

      if (this.get('hasTextChanged')) {
        this.get('model').save();
      }
    },
    newLineInserted: function() {
      // This will trigger a 'focus-out' event
      this.$('textarea').blur();
    }
  }
});

PageOne.InplaceTextareaView = Ember.TextArea.extend({
  /* Helpers */
  _doFocus: function() {
    if (this.get('doFocus')) {
      this.$().focus();
      this.set('doFocus', false);
    }
  },
  /* Callbacks */
  didInsertElement: function () {
    this.$().autosize();
    // Focus if it's initially focused.
    this._doFocus();
    // Prevent carriage returns to be inserted when pressing 'Enter'.
    this.$().keypress(function(event) {
      if(event.which == '13') {
        $(this).blur();
        // Trigger focusOut event
        return false;
      }
    });
  },
  willDestroyElement: function() {
    // Remove the autosize
    this.$().autosize('autosize.destroy');
  },
  /* Observers */
  onDoFocus: function() {
    // If it's been added to the DOM
    if (this.$()) {
      this._doFocus();
    }
  }.observes('doFocus'),
});

Ember.Handlebars.helper('inplace-textarea', PageOne.InplaceTextareaView);
