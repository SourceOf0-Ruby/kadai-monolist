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
        item = Item.find_or_initialize_by(read(result));
        @items << item;
      end
    end
  end

  def show
    @item = Item.find(params[:id]);
    @want_users = @item.want_users;
  end

end
