class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :logout, :log_in_user!
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token]) #needs to be or-equals because this is also a getter
  end

  def logged_in?
    !!current_user #if there is a current user, or if theres none(nil)
  end #also creates one if it is currently nil, because it calls this function too!!

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

end
