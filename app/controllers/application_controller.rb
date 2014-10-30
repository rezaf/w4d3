class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # before_action :ensure_logged_in
  
  def current_user
    return nil if self.session[:session_token].nil?
    @user ||= User.find_by(session_token: self.session[:session_token])
  end
  
  def log_in!(user)
    user.reset_session_token!
    self.session[:session_token] = user.session_token
  end
  
  def log_out!
    self.session[:session_token] = nil
  end
  
  def ensure_logged_in
    redirect_to cats_url if current_user.nil?
  end
  
  helper_method :current_user
end
