require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Musicbox
  class Application < Rails::Application
    config.load_defaults 5.2
    # devise flashメッセージの日本語設定
    config.i18n.default_locale = :ja
  end
end
