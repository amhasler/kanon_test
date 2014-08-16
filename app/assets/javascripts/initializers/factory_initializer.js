
PageOne.Factory = Ember.Object.extend();

Ember.Application.initializer({
  name: 'factory',
  initialize: function(container, application) {
    application.register('factory:basic', PageOne.Factory);

    application.inject('factory', 'store', 'store:main');
  }
});