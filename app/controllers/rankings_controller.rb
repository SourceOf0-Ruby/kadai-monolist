class RankingsController < ApplicationController
  
  # ログイン時のみ
  before_action :require_user_logged_in;
  
  def want
    @ranking_counts = Want.ranking;
    @items = Item.find(@ranking_counts.keys);
  end
  
  def have
    @ranking_counts = Have.ranking;
    @items = Item.find(@ranking_counts.keys);
  end
  
end
