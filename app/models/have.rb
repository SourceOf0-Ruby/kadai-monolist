class Have < Ownership
  
  # Have数ランキングを取得
  # @return: [:item_id, Have総数]のハッシュ
  def self.ranking
    # 同item_idでグループ化し、総数降順で並べたうちの最初の10個の[:item_id, Have総数]のハッシュを返す
    return self.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id);
  end
  
end
