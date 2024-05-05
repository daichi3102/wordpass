require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wordpass
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Set the default locale to Japanese
    config.i18n.default_locale = :ja

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Custom generator configuration
    config.generators do |g|
      g.assets false                         # TailwindCSSを使っているので CSS/JSファイルの生成をしない
      g.skip_routes true                     # trueにより routes.rbの変更をしない
      g.helper false                         # helperファイルの生成をしない
      g.test_framework :rspec,               # テストフレームワークはrspecを使用する可能性
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: false,
                       model_specs: true,
                       fixtures: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories' # fixtureはfactory_botを使用
    end
  end
end
