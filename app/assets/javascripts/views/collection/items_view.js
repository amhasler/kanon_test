PageOne.CollectionItemsView = Ember.CollectionView.extend({
  tagName: 'article',
  classNames: ['collection'],
  itemViewClass: PageOne.CollectionItemView,
  didInsertElement: function() {
    var self = this;
  },
  // Returns all Views associated with an item in this collection. Collection items are not counted.
  itemViews: function() {
    var self = this;
    return this.get('childViews').sortBy('position');
  }.property('childViews.@each.position'),
  actions: {
    // Called by an ItemView when it's done being dragged.
    itemMoved: function(itemView) {

      // First determine until where we've moved.
      var $item = itemView.$();

      // Insert `itemView` after `previousItemView`
      var previousItemView = null;
      this.get('itemViews').reject(function(_itemView) {
        return itemView == _itemView;
      }).forEach(function(_itemView) {
        previousItemView = _itemView;
      });

      // Reset its position, in case it hasn't moved.
      itemView.$().css('top', '');

      // Delegate the actual moving to the collection controller.
      itemView.get('controller.controllers.collection').send('moveItemBefore', itemView.get('controller.content'), previousItemView.get('controller.content'));
    }
  }
});
