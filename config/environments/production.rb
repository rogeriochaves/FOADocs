# encoding: UTF-8
AppName::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true
  config.eager_load = true

  config.cache_store = :dalli_store
  config.action_dispatch.rack_cache = {
    :metastore    => Dalli::Client.new,
    :entitystore  => 'file:tmp/cache/rack/body',
    :allow_reload => false
  }

  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger.const_get(ENV['LOG_LEVEL'] ? ENV['LOG_LEVEL'].upcase : 'INFO')

  # Show full error reports and disable caching
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=2592000"
  config.assets.compress = true
  config.assets.compile = true
  config.assets.digest = true
  config.assets.css_compressor = :yui
  config.assets.js_compressor = :uglifier

  config.middleware.use ExceptionNotifier,
    :email_prefix => "[Erro] ",
    :sender_address => %{"Notificação de Erro" <naoresponda@reactweb.com.br>},
    :exception_recipients => %w{rogerio@reactweb.com.br}

  config.middleware.use "YesWww"
  
end