PageOne.CollectionItemView = Ember.View.extend({
  templateName: 'collection/item',
  classNames: ['item-wrapper'],
  classNameBindings: ['controller.type', 'itemId', 'isLastItem:last', 'isFirstItem:first', 'controller.isEditing:edit:public'],
  _initialize: function() {
    var content = this.get('content');
    var controller = this.container.lookupFactory('controller:' + this.get('itemControllerType')).create({
      content: content,
      view: this
    });

    this.set('controller', controller);
  }.on('init'),
  // We created the controller manually, so we have to destroy it too.
  willDestroyElement: function() {
    this.get('controller').destroy();
  },
  itemControllerType: 'collectionItem',
  /* Properties */
  // Position of the item
  position: function() {
    return this.get('controller.content.position');
  }.property('controller.content.position'),
  // Returns true iff this item is the last one in the section
  isLastItem: function() {
    return this == this.get('parentView.itemViews.lastObject');
  }.property('parentView.itemViews.lastObject'),
  // Returns true iff this item is the first one in the section
  isFirstItem: function() {
    return this == this.get('parentView.itemViews.firstObject');
  }.property('parentView.itemViews.firstObject'),
  itemId: function() {
    return 'item-' + this.get('controller.id');
  }.property('controller.id'),
  showCreateNewItemButton: function() {
    return this.get('controller.isEditing') && this.get('isLastItem');
  }.property('controller.isEditing', 'isLastItem'),
  /* Callbacks */
  didInsertElement: function() {

    // Listen to the controller when a new item is added
    // controller = this.get('controller').on();

    // Make it draggable
    var self = this;
    this.$().draggable({
      axis: "y",
      handle: ".button-move-item",
      stop: function(collection, ui) {
        Ember.run(function() {
          // Tell the ItemsView that we moved this item.
          self.get('parentView').send('itemMoved', self);
        });
      }
    });
  },
  /* Callbacks */
  // Called when a new item has been created.
  onItemCreated: function() {
    // Indicate to the new item that it's just been created. 
    this.set('parentView.itemViews.lastObject.controller.isCreated', true);
    // Disable the show dialog.
    this.set('showDialogCreateNewItem', false);
  },
  actions: {
    toggleDialogCreateNewItem: function() {
      this.toggleProperty('showDialogCreateNewItem');

      if (this.get('showDialogCreateNewItem')) {
        // this.closeOnClickAnywhere('showDialogCreateNewItem', this.$('.create-new-item'));
        var self = this;
        this.closeOnClickAnywhere(function() {
          self.set('showDialogCreateNewItem', false);
        }, this.$('.create-new-item'));
      }
    }
  }
});
