module SessionsHelper
  def sign_in_user(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in_user?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in_user?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out_user
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.referer
  end

  def correct_user
    @user = User.find_by_permalink(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
