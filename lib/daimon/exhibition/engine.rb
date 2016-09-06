require 'daimon/exhibition/model'
require 'daimon/exhibition/controller'

module Daimon
  module Exhibition
    class Engine < ::Rails::Engine
      isolate_namespace Daimon::Exhibition

      initializer 'daimon-exhibition.setup' do |app|
        ActiveSupport.on_load :active_record do
          ActiveRecord::Base.singleton_class.prepend Module.new {
            def inherited(base)
              super

              base.include Model unless base < Model
            end
          }
        end

        ActiveSupport.on_load :action_controller do
          ActionController::Base.singleton_class.prepend Module.new {
            def inherited(base)
              super

              base.include Controller unless base < Controller
            end
          }
        end
      end
    end
  end
end
