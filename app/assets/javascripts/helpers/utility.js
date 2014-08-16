PageOne.Utility = Ember.Object.createWithMixins({
  /* Camelises an object or array of objects. Used for receiving JSON from the API. */
  normalize: function(hash) {
    var self = this;
    var $ = Ember.$;

    if ($.isPlainObject(hash) || $.isArray(hash)) {
      // Make a copy
      var ret = this.copyObject(hash); 

      $.each(hash, function(key, value) {
        var normKey = key;
        if ($.type(key) === "string") {
          normKey = Ember.String.camelize(key);
        }

        // Only copy the value if it's not null
        if (value !== null && value !== undefined) {
          ret[normKey] = self.normalize(value);
        }
        if (normKey != key) {
          delete ret[key];
        }
      });
      return ret;
    } else {
      return hash;
    }
  },
  /* Decamelises an object or array of objects. Used for send JSON to the API. */
  serialize: function(hash) {
    var self = this;
    var $ = Ember.$;

    if ($.isPlainObject(hash) || Ember.isArray(hash)) {
      // Make a copy
      var ret = this.copyObject(hash); 
      $.each(hash, function(key, value) {
        var normKey = Ember.String.decamelize(key.toString());
        ret[normKey] = self.serialize(value);
        if (normKey != key) {
          delete ret[key];
        }
      });
      return ret;
    } else {
      return hash;
    }
  },
  /* Filters an object based on the given attributes */
  permit: function(obj, attrs) {
    if ($.isPlainObject(obj)) {
      var res = {};
      Ember.$.each(attrs, function(index, attr) {
        res[attr] = obj[attr];
      });
      return res;
    } else {
      return obj;
    }
  },
  copyObject: function(obj) {
    return JSON.parse(JSON.stringify(obj));
  },
  /* Routes */
  /* Returns the current path based on the current url. */
  getCurrentPath: function() {
    var loc = window.location;
    var page = loc.hash ? loc.hash.substring(1) : loc.pathname + loc.search;
    return page;
  },
  /* Removes all null and undefined values */
  cleanObject: function(obj) {
    var self = this;
    if ($.isPlainObject(obj) || $.isArray(obj)) {
      $.each(obj, function(key, value) {
        if (value == null || value == undefined) {
          delete hash[key];
        } else {
          self.cleanObject(value);
        }
      });
    }
  },
  _ajaxRequest: function(type, url, data) {
    return new Ember.RSVP.Promise(function(resolve, reject) {
      Ember.$.ajax({
        type: type,
        url: url,
        data: data,
        dataType: "json"
      }).done(function(responseData) {
        Ember.run(function() { resolve(responseData); });
      }).fail(function(responseData) {
        Ember.run(function() { reject(responseData); });
      });
    });
  },
  get: function(url, data) {
    return this._ajaxRequest("GET", url, data || {});
  },
  post: function(url, data) {
    return this._ajaxRequest("POST", url, data);
  },
  put: function(url, data) {
    return this._ajaxRequest("PUT", url, data);
  },
  delete: function(url, data) {
    return this._ajaxRequest("DELETE", url, data);
  }
});
