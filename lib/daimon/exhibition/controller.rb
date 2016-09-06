module Daimon
  module Exhibition
    module Controller
      class << self
        def included(base)
          base.extend ::Daimon::Exhibition::MylistSupport
        end
      end
    end
  end
end
