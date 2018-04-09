class User < ApplicationRecord
  
  before_save { self.email.downcase! };
  
  validates :name, presence: true, length: { maximum: 50 };
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false };

  has_secure_password;
  
  has_many :ownerships;
  has_many :items, through: :ownerships;
  
  has_many :wants;
  has_many :want_items, through: :wants, class_name: 'Item', source: :item;
  
  has_many :haves, class_name: 'Have';  # 自動識別でHafeクラスと紐づけられてしまうので指定
  has_many :have_items, through: :haves, class_name: 'Item', source: :item;
  
  
  
  # 商品を欲しいものリストに追加する
  # @param item: 対象の商品のitemモデルインスタンス
  def want(item)
    self.wants.find_or_create_by(item_id: item.id);
  end
  
  # 商品を欲しいものリストから外す
  # @param item: 対象の商品のitemモデルインスタンス
  def unwant(item)
    want = self.wants.find_by(item_id: item.id);
    want.destroy if want;
  end
  
  # 商品が欲しいものリストに含まれているか確認する
  # @param item: 対象の商品のitemモデルインスタンス
  def want?(item)
    self.want_items.include?(item);
  end
  

  # 商品を持ってるものリストに追加する
  # @param item: 対象の商品のitemモデルインスタンス
  def have(item)
    self.haves.find_or_create_by(item_id: item.id);
  end
  
  # 商品を持ってるものリストから外す
  # @param item: 対象の商品のitemモデルインスタンス
  def unhave(item)
    have = self.haves.find_by(item_id: item.id);
    have.destroy if have;
  end
  
  # 商品が持ってるものリストに含まれているか確認する
  # @param item: 対象の商品のitemモデルインスタンス
  def have?(item)
    self.have_items.include?(item);
  end
  
end
