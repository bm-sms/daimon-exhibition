class ApplicationController < ActionController::Base
  enable_to_read_mylist

  protect_from_forgery with: :exception
end
