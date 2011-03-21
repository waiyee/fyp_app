class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include Facebooker2::Rails::Controller

end
