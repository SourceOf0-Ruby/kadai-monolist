class ApplicationController < ActionController::Base

  # CSRF対策
  # 参考:http://hakutoitoi.hatenablog.com/entry/2013/01/05/014857
  protect_from_forgery with: :exception;

  # ログイン周りのメソッドを使用するためinclude
  include SessionsHelper;
  
  
  private
  
  # ログインしていない場合はログインページにリダイレクトする
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url;
    end
  end
  
  # 楽天APIから取得した商品情報を読み取る
  # @param result: 取得した情報のハッシュ
  # @return: itemモデル用ハッシュ
  def read(result)
    code       = result['itemCode'];
    name       = result['itemName'];
    url        = result['itemUrl'];
    
    # URL末尾のサイズ指定をgsubで文字列置換して原寸サイズのURLを取得
    image_url  = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '');
    
    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    };
  end
  
end
