module SessionsHelper
  
  # ログイン済みのユーザモデルインスタンスを@current_userにセットする
  def current_user
    # @current_userがnilでない場合はDBから取得する
    # MEMO: find   は見つからなかったときエラーを投げる
    #       find_byは見つからなかったときnilを返す
    @current_user ||= User.find_by(id: session[:user_id]);
  end
  
  # ログイン済みであればtrueを返す
  def logged_in?
    return !!current_user;
  end
  
end
