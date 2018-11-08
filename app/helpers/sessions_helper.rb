module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= Artist.find_by(id: session[:user_id])
    end
  end
  
  # ユーザーがログインしていればtrue, その他ならばfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # ユーザーのログアウト
  def log_out 
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 記憶したURL(もしくはデフォルト値)にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  
  #アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
end
