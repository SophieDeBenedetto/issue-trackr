class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate
  helper_method :logged_in?, :current_user, :authenticate, :log_in

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def authenticate
    redirect_to root_path unless logged_in?
  end
end
