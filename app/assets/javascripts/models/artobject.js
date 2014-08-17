PageOne.Artobject = DS.Model.extend({
  /* Associations */
  item: DS.belongsTo('item'),
  author: DS.belongsTo('user'),
  /* Attributes */
  name: DS.attr('string'),
  day: DS.attr('number'),
  month: DS.attr('number'),
  year: DS.attr('number'),
  minday: DS.attr('number'),
  minmonth: DS.attr('number'),
  minyear: DS.attr('number'),
  maxday: DS.attr('number'),
  maxmonth: DS.attr('number'),
  maxyear: DS.attr('number'),
  approximatedate: DS.attr('number'),
  // Image
  image: DS.attr('image'),
  
  /* Observers */
  // Manually make the item dirty on `image.caption` change. The reason is that `image` is an object and changes on its properties don't make the item dirty.
  // _onImageChange: function() {
  //   this.adapterDidDirty();
  // }.observes('image.caption'),

});

// PageOne.ArtobjectSerializer = DS.RESTSerializer.extend({
  // Allowable attributes
//  serializeAttribute: function(item, json, key, attribute) {
//    if (key == "name" || key == "content" || key == "position") {
//      this._super(item, json, key, attribute);
//    }
//  },
// });
