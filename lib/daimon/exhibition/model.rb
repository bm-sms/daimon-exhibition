module Daimon
  module Exhibition
    module Model
      class << self
        def included(base)
          base.extend ::Daimon::Exhibition::Exhibit
          base.extend ::Daimon::Exhibition::Inquiry
        end
      end
    end
  end
end
