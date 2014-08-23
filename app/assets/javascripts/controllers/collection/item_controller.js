PageOne.CollectionItemController = Ember.ObjectController.extend({
  needs: ['collection'],
  collectionController: function() {
    return this.get('controllers.collection');
  }.property('controllers.collection'),
  /* Properties */
  isEditing: Ember.computed.alias('collectionController.isEditing'),
  // showAddAnImageButton: Em.computed.and('hasNoImage', 'isNotAddingImage'),
  isDeletable: function() {
    // An item of a section is not deletable if it's both the first and the last item (i.e. it's the only item in the chapter).
    return ! (this.get('view.isFirstItem') && this.get('view.isLastItem'));
  }.property('view.isFirstItem', 'view.isLastItem'),

  /* Actions */
  actions: {
    createNewItem: function(type) {
      // Delegate to the timeline controller
      // this.get('controllers.timeline').send('createNewItem', this.get('model'), type);
      this.get('collectionController').send('createNewItem', this.get('model'));

      this.trigger('itemCreated');
    },
    deleteItem: function() {
      // Delegate to the timeline controller
      // this.get('controllers.timeline').send('deleteItem', this.get('model'));
      this.get('collectionController').send('deleteItem', this.get('model'));
    }
  }
});
