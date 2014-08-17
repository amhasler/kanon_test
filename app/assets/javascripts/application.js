// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.

// ==== Jquery and HTML ==== 
//= require ./lib/modernizr.custom.min
//= require jquery
//= require jquery_ujs
//= require ./lib/jquery-ui-1.10.4.custom

// ==== Handlebars ====
//= require moment
//= require handlebars

// ==== Ember ====
//= require ./ember.configuration
//= require ember
//= require ember-data

// === Vendor ====
//= require bootstrap-fileupload
//= require jquery.tokeninput
//= require jquery.big-slide

// ==== Pluralization ====
//= require ./lib/ember.cldr
//= require ./lib/ember.i18n

// ==== Client-side validation ====
//= require ./lib/ember.validations

//= require_self
//= require page_one


PageOne = Ember.Application.create({
  LOG_TRANSITIONS: true,
  LOG_ACTIVE_GENERATION: true,
  rootElement: '#main'
});

Ember.ENV.RAISE_ON_DEPRECATION = true;
Ember.LOG_STACKTRACE_ON_DEPRECATION = true;

//= require_tree .