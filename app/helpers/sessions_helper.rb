module SessionsHelper
  def log_in(user)
    session[:user] = user.id
  end
end
