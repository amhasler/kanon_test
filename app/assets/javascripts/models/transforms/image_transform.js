/* Add an 'image' type for models */
PageOne.ImageTransform = DS.Transform.extend({
  serialize: function(value) {
    if (value) {
      return {
        identifier: value.identifier,
        url: value.url,
        thumb_url: value.thumbUrl,
        caption: value.caption
      };
    } else {
      return null;
    }
  },
  deserialize: function(value) {
    if (value) {
      return PageOne.Image.create({
        identifier: value.identifier,
        url: value.url,
        thumbUrl: value.thumbUrl,
        caption: value.caption || "",
      });
    } else {
      return null;
    }
  }
});