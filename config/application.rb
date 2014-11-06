require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Troopr
  class Application < Rails::Application

    AVATAR_DEFAULTS= [
      'https://www.filepicker.io/api/file/4jnwDuuUSo6nx0RgkaHN',
      'https://www.filepicker.io/api/file/sTX6eUk1Tqq6UxIWtiB0',
      'https://www.filepicker.io/api/file/MGh0U0GWRDa8HLKvteJ0',
      'https://www.filepicker.io/api/file/0MqJ0DtzSz6QaYI1h7CG',
      'https://www.filepicker.io/api/file/WdIeC3i1QXiFN9fDaQX1',
      'https://www.filepicker.io/api/file/2bDOO6xVRpqbGEaz8UEP',
      'https://www.filepicker.io/api/file/OTpSnIKZRheksHULnnXn',
      'https://www.filepicker.io/api/file/RxffJqDTSCyw4R7hgQwj'
    ]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.


    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
