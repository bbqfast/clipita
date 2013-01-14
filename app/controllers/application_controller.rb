class ApplicationController < ActionController::Base
  protect_from_forgery

private

def current_user
  # todo:  need to handle case when user get deleted from database
  # and find throws exception
  #session[:user_id] = nil
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
helper_method :current_user

end
