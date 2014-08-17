PageOne.Collection = DS.Model.extend({
  /* Associations */
  items: DS.hasMany('item'),
  author: DS.belongsTo('user'),
  /* Attributes */
  title: DS.attr('string'),
  introductionContent: DS.attr('string'),
  cover: DS.attr('image'),
  // isPublished: DS.attr('boolean'),
  // updatedAt: DS.attr('date'),
  // Only for user timelines
  // Indicates when the timeline was first published
  // firstPublishedAt: DS.attr('date'),
  /* Validations */
  // validations: {
  //  title: {
  //    presence: {
  //      if: 'isPublishing',
  //      message: "The title of the timeline can't be blank."
  //   }
  //  }
  // },
  /* Properties */
  // Stores the 'id' as a numeric type rather than a string (see https://github.com/emberjs/ember.js/issues/2034)
  numericId: function() {
    return parseInt(this.get('id'));
  }.property('id'),
  /* Set when it's trying to publish */
  isPublishing: false,
  // It's editing if it's not publishing
  isEditing: function() {
    return ! this.get('isPublished');
  }.property('isPublished'),
  // Returns true if the timeline has been published at least once
  hasBeenPublished: function() {
    return ! Ember.isBlank(this.get('firstPublishedAt'));
  }.property('firstPublishedAt'),
  /* Only return the 'quote', 'image' and 'chapter' and 'video' items, sorted by position. */
  sortedItems: function() {
    return this.get('items').sortBy('position');
  }.property('items.@each', 'items.@each.position', 'items.@each.isChapter', 'items.@each.isImage', 'items.@each.isQuote', 'items.@each.isVideo', 'items.@each.isDidYouKnow', 'items.@each.isQuizQuestionMultipleChoice')
});

