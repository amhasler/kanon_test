PageOne.CollectionController = Ember.ArrayController.extend({
  /* Properties */
  isEditing: false,
  isPublishing: false,
  init: function() {
    this._super();
  },
  // If it's either editable or shareable with a class
  canPerformTimelineActions: function() {
    return this.get('isEditable') || this.get('isShareableWithClass');
  }.property('isEditable', 'isShareableWithClass'),
  /* Helpers */
  // Deletes a model and saves it if it's persisted.
  _deleteModel: function(model) {
    var promise;
    if (model.get('isNew')) {
      // Not persisted, merely delete
      promise = model.deleteRecord();
    } else {
      // Persisted, delete and save (done by destroyRecord)
      promise = model.destroyRecord();
    }
    return Ember.RSVP.Promise.cast(promise);
  },
  // Removes the item and updates its relationship with 'timeline' as it's async
  _deleteItem: function(item) {
    // Remove from the timeline cause it's an 'async' relation
    this.get('content.items').then(function(items) {
      items.removeObject(item);
    });

    this._deleteModel(item);
  },
  // Returns all items that have a position strictly greater than `position`.
  _itemsAfterPosition: function(position) {
    return this.get('items').filter(function(item) {
      return item.get('position') > position;
    });
  },
  // Creates an item and prepares its addition to the DOM.
  _prepareItem: function(afterItem, type) {
    var collection = this.get('content');

    var itemsAfter = this._itemsAfterPosition(afterItem.get('position'));
    // Increment the position of the next items because we're putting this one in between
    itemsAfter.forEach(function(item) {
      item.incrementProperty('position');
    });

    // Create the item
    var item = this.store.createRecord('item', {
      collection: this.get('content'),
      position: afterItem.get('position') + 1,
      content: ""
    });

    var store = this.store;

    Em.debug('Saving item');

    var promises = [];

    var promise;

    // Async relationships are not automatically set
    collection.get('items').then(function(items) {
      items.addObject(item);
    });

    return item;
  },
  // Creates a new item positioned after item `afterItem`. Returns the new item.
  _createItem: function(afterItem, type) {
    var item = this._prepareItem(afterItem, type);

    // Manually add it to its itemSection
    var itemSection = afterItem.get('itemSection');
    itemSection.pushObject(item);
    item.set('itemSection', itemSection);

    return item;
  },
  actions: {
    /* Inserts a new item of type `type` after item `afterItem` */
    createNewItem: function(afterItem, type) {
      this._createItem(afterItem, type);

      // Analytics
      this.trackEvent("Timeline Item Creation", {
        "$item_type": type
      });
    }
  }
});
