PageOne.CollectionRoute = Ember.Route.extend({
	model: function(params) {
    collection = this.store.find('collection', params.id);
    return Ember.RSVP.hash({
      collection: collection,
      items: collection.get('items'),
      author: collection.get('author')
    });
    
  },
  setupController: function(controller, modelHash) {
    // Setup the controller
    controller.setProperties(modelHash);
  }
});

