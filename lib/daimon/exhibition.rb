require 'daimon/exhibition/engine'

module Daimon::Exhibition
  class << self
    def routes(exhibit, router)
      router.instance_eval do
        # TODO `resources` だけで表現したい
        resources exhibit, only: %i(index destroy) do
          post   '/', action: :create,      on: :member
          delete '/', action: :destroy_all, on: :collection
        end
      end
    end
  end
end
