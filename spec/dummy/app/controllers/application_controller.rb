class ApplicationController < ActionController::Base
  include Daimon::Exhibition::Controller

  enable_to_read_mylist

  protect_from_forgery with: :exception
end
