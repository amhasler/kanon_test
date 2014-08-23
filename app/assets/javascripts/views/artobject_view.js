PageOne.ArtobjectView = Ember.View.extend({
  templateName: 'artobject',
  classNames: ['artobject-wrapper'],
  classNameBindings: ['artobjectId'],
  init: function() {
  	this._super();
  },
  artobjectId: function() {
    return 'artobject-' + this.get('controller.id');
  }.property('controller.id')
});
