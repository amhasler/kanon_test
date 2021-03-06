PageOne.User = DS.Model.extend({
  /* Associations */
  collections: DS.hasMany('collection', { async: true }),
  /* Attributes */
  email: DS.attr('string'),
  name: DS.attr('string'),
  // Student-specific
  username: DS.attr('string'),
  cover: DS.attr('image')
});
