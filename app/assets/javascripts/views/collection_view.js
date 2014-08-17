PageOne.CollectionView = Ember.CollectionView.extend({
  tagName: 'article',
  classNames: ['collection'],
  itemViewClass: PageOne.CollectionItemView,
  didInsertElement: function() {
    var self = this;

    // Recalculate when changing orientation
    Ember.$(window).on('orientationchange', function() {
      Ember.run.once(self, self._performViewActions);
    });
  },
  /* When the item views change, force a recalculation of the ordering */
  _itemViewsChanged: function() {
    Ember.run.once(this, this._performViewActions);
  }.observes('itemViews'),
  _hasImages: function() {
    return this.$() && this.$('img').length > 0;
  },
  // Returns all Views associated with an item in this chapter. Chapter items are not counted.
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

      // Delegate the actual moving to the timeline controller.
      itemView.get('controller.controllers.collection').send('moveItemBefore', itemView.get('controller.content'), previousItemView.get('controller.content'));
    },
    heightOfItemModified: function() {
      Ember.run.once(this, this._performViewActions);
    }
  }
});