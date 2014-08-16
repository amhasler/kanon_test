(function() {
  Ember.Validations.validators.local.Correctness = Ember.Validations.validators.Base.extend({
    init: function() {
      this._super();
      /*jshint expr:true*/
      if (this.options === true) {
        this.set('options', {});
      }

      if (this.options.message === undefined) {
        this.set('options.message', Ember.Validations.messages.render('correct', this.options));
      }
    },
    call: function() {
      var array = this.model.get(this.property);
      if (Ember.isArray(array)) {
        if (Ember.isEmpty(array) || (array.compact().filterBy('correct', true).get('length') === 0)) {
          this.errors.pushObject(this.options.message);
        }
      }
    }
  });
})();

(function() {
  Ember.Validations.validators.local.Uniqueness = Ember.Validations.validators.Base.extend({
    init: function() {
      this._super();
      /*jshint expr:true*/
      if (this.options === true) {
        this.set('options', {});
      }

      if (this.options.message === undefined) {
        this.set('options.message', Ember.Validations.messages.render('correct', this.options));
      }
    },
    call: function() {
      var array = this.model.get(this.property);
      if (Ember.isArray(array)) {
        var answers = array.compact().mapBy('text');
        if (!Ember.isEmpty(answers) && (answers.uniq().get('length') < answers.get('length'))) {
          this.errors.pushObject(this.options.message);
        }
      }
    }
  });

})();

(function() {
  Ember.Validations.validators.local.NotBlankHtml = Ember.Validations.validators.Base.extend({
    init: function() {
      this._super();
      /*jshint expr:true*/
      if (this.options === true) {
        this.set('options', {});
      }

      if (this.options.message === undefined) {
        this.set('options.message', Ember.Validations.messages.render('blank', this.options));
      }
    },
    call: function() {

      var html = this.model.get(this.property);
      var blank = true;
      if (!Ember.isBlank(html)) {

        var parsedHTML = $.parseHTML(html);

        $.each(parsedHTML, function(i, el) {
          if (!Em.isBlank(el.innerText)) {
            blank = false;
          }
        });

        if (blank) {
          this.errors.pushObject(this.options.message);
        }
      }
    }
  });
})();
