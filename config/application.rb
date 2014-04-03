require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'sprockets/railtie'

Bundler.require(:default, Rails.env)

module Fnfi
  class Application < Rails::Application
    config.time_zone = 'Pacific Time (US & Canada)'
    Rack::MiniProfiler.config.position = 'right'
		config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

		config.autoload_paths += %W(#{config.root}/lib)

		config.generators do |g|
			g.test_framework :rspec,
				fixtures: true, 
				view_specs: false,
				helper_specs: false,
				routing_specs: false,
				controller_specs: false,
				request_specs: false
			g.fixture_replacement :factory_girl, dir: "spec/factories"
		end
  end
end


