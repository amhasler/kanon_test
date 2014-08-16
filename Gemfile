source 'https://rubygems.org'

ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.5'
# Unicorn web server
gem 'unicorn'
# Assets and media
gem 'carrierwave'
gem 'rmagick', require: false
gem 'mime-types'
#  Unicode Normalization Form
gem 'unf'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# JSON Serializer
gem 'active_model_serializers'
# Customise JSON response for errors
gem 'responders'
# For seed data
gem 'faker'
# Remove once bootstrap and vanilla rails
# features gone
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
# Acts-as-list
gem 'acts_as_list'
# Indent-sensitive preprocessor for html
gem 'haml-rails'
# API Documentation
gem 'apipie-rails'
# Allow for tagging in the database, could
# do this better.
gem 'acts-as-taggable-on'
# Squeel lets you write your Active Record queries with fewer strings.
# https://github.com/activerecord-hackery/squeel
gem "squeel"
# Allows for nested nav. Remove once converted
# to ember, when nav will have a controller.
gem "breadcrumbs_on_rails"

group :assets do
  # JQuery doesn't load from just ember. I don't
  # know why.
  gem 'jquery-rails'
  # Will get rid of this when I phase out bootstrap
  gem 'bootstrap-sass', '2.3.2.0'
  # Use SCSS for stylesheets
  gem 'sass-rails'
  # See https://github.com/sass/sass/issues/1162
  gem 'sass', '~> 3.2.0'
  # Bourbon library for SASS mixins
  gem 'bourbon', '3.2.0'
  # Neat library for grid
  gem 'neat', '~> 1.5.0'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'
  # Ember.js
  gem 'ember-rails'
  gem 'ember-source', '1.6.1'
  gem 'ember-data-source'
  #lock Sprockets to (2.10.1) http://stackoverflow.com/questions/22391116/nomethoderror-in-pageshome-undefined-method-environment-for-nilnilclass)
  gem 'sprockets', '2.11.0'
  # Format dates with moment.js
  gem 'momentjs-rails'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do

  gem 'shoulda-matchers'
  gem 'rspec-its'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'growl', '1.0.3'
  gem 'webmock'
end

group :test, :development do
  gem 'sqlite3', '1.3.8'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'guard-rspec', '3.1.0'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork'
  gem 'childprocess'
  # Javascript testing
  gem 'qunit-rails'
  gem 'teaspoon'
  gem 'rails-erd'
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end
