require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "daimon/exhibition"

module Dummy
  class Application < Rails::Application
    config.app_generators do |g|
      g.helper false
      g.assets false
    end

    initializer "daimon-exhibition.set_factory_paths", after: "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths << config.root.join('spec/factories') if defined?(FactoryGirl)
    end
  end
end

