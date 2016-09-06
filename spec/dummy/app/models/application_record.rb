class ApplicationRecord < ActiveRecord::Base
  include Daimon::Exhibition::Model

  self.abstract_class = true
end
