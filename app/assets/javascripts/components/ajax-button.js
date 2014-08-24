PageOne.AjaxButtonComponent = Ember.Component.extend({
  tagName: 'span',
  classNames: ['button-container'],
  classNameBindings: ['spinnerPosition', 'name', 'loadingCondition:waiting'],
  /* Properties */
  spinnerPosition: "left",
});