PageOne.Item = DS.Model.extend({
  /* Associations */
  collection: DS.belongsTo('collection'),
  artobject:  DS.belongsTo('artobject')
 
});

