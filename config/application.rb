require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Fnfi
  class Application < Rails::Application
    config.time_zone = 'Pacific Time (US & Canada)'
    Rack::MiniProfiler.config.position = 'right'

		config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

  end
end
