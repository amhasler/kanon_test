// To be mixed-in a controller.
PageOne.EditableCollectionMixin = Ember.Mixin.create({
  /* Query params */
  queryParams: ['edit'],
  edit: false,
  /* Properties */
  isEditing: Ember.computed.alias('edit'),
  // A timeline is editable if the current user is its author
  // isEditable: function() {
  //   return this.get('author') == this.get('session.currentUser');
  // }.property('author', 'session.currentUser'),
  /* Actions */
  actions: {
    /* Publishes the timeline. */
    /*
    publish: function() {
      this.set('waitingForTimelinePublish', true);

      var self = this;
      var validationsPromises = [];
      var timeline = this.get('content');

      // We're publishing, not published yet.
      timeline.set('isPublishing', true);

      // Validate the timeline
      validationsPromises.push(timeline.validate());

      // Validate the items
      timeline.get('items').forEach(function(item) {
        validationsPromises.push(item.validate());
        if (item.get('isQuizQuestionMultipleChoice')) {
          item.get('quizQuestionAnswers').forEach(function(answer) {
            validationsPromises.push(answer.validate());
          });
        }
      });
      // Validate the timeline conclusions
      timeline.get('timelineConclusions').forEach(function(timelineConclusion) {
        validationsPromises.push(timelineConclusion.validate());
      });

      Ember.RSVP.all(validationsPromises).then(function() {
        // Send the update to the server once every item is validated.
        // This causes bug https://github.com/emberjs/ember.js/issues/4231 because we used the 'isPublished' property as a sorting criteria in TeacherTimelinesController.
        timeline.setProperties({
          isPublishing: false,
          isPublished: true
        });

        timeline.save().then(function() {
          // We're published now
          self.set('isEditing', false);

          // Analytics timeline
          self.trackEvent("Timeline Publication", {
            "$timeline_title": timeline.get('title'),
            "$number_of_items": timeline.get('items.length')
          });

        }, function() {
          self.set('isPublished', false);
        }).finally(function() {
          self.set('waitingForTimelinePublish', false);
        });
      }, function() {
        self.set('waitingForTimelinePublish', false);
      });
    },
    */
    /* Edits the timeline, and say that we haven't published yet to enforce validations. */
    edit: function() {
      var self = this;
      var collection = this.get('content');

      this.set('waitingForCollectionEdit', true);

      // timeline.set('isPublished', false);
      collection.save().andThen(function() {
        self.set('isEditing', true);
      }, function() {
        collection.rollback();
      }, function() {
        self.set('waitingForCollectionEdit', false);
      });
    },
  }
});
