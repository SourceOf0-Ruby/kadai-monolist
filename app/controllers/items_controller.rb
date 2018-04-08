class ItemsController < ApplicationController
  
  # ログイン時のみ表示するページを指定
  before_action :require_user_logged_in;
  
  def new
    @items = []; # 検索結果を入れるだけ
    
    @keyword = params[:keyword];
    if @keyword.present?
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      });
      results.each do |result|
        item = Item.new(read(result));
        @items << item;
      end
    end

  end
  
  
  private
  
  
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
