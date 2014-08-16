require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env, :assets)
# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module KanonTest
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.available_locales = [:en]
    config.i18n.enforce_available_locales = true

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.initialize_on_precompile = false
    # Precompile additional assets
    config.assets.precompile += ['modernizr.js']
    config.assets.precompile += %w( .svg .eot .woff .ttf )

    # Preload files in the /lib directory
    config.autoload_paths += %W(#{config.root}/lib)

    # Poll interval for live updates (in seconds)
    config.poll_interval = 30
  end
end
