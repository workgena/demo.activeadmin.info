class ApplicationController < ActionController::Base
  include Authentication
  include Pundit
  protect_from_forgery
end
