class Post < ApplicationRecord
  belongs_to :user
    
  has_many :post_janles 
  has_many :janles, through: :post_janles
    
  has_many :likes
  has_many :users, through: :likes

  mount_uploader :post_image, ImageUploader

  validates :title, {presence: true, length: {maximum: 15}}
  validates :content, {presence: true, length: {maximum: 140}}
  validates :post_image, {presence: true}
  validates :user_id, {presence: true}


  def save_janle(sent_janles)
    current_tags = self.janles.pluck(:janle) unless self.janles.nil?
    old_janles = current_tags - sent_janles
    new_janles = sent_janles - current_tags
    old_janles.each do |old|
      self.janles.delete Janle.find_by(janle: old)
    end
    new_janles.each do |new|
      new_post_tag = Janle.find_or_create_by(janle: new)
      self.janles << new_post_tag
    end
  end
#あくまでもself.janlesでは中間テーブルを介して結合したテーブルからjanleの方を表示している。だから、追加したら中間テーブルにも追加される。
#self.janlesでpostに関連するjanleを配列で取得している。そこに、新たなjanleを追加することで、中間テーブルにも追加できるのかな?  

  def self.return_posts(janle_name)
    case janle_name
    when '遊び'
      janle = Janle.find_by(janle: janle_name)
      posts = janle.posts.order(created_at: :desc)
    when 'デート'
      janle = Janle.find_by(janle: janle_name)
      posts = janle.posts.order(created_at: :desc)
    when 'ドライブ'
      janle = Janle.find_by(janle: janle_name)
      posts = janle.posts.order(created_at: :desc)
    when '映え'
      janle = Janle.find_by(janle: janle_name)
      posts = janle.posts.order(created_at: :desc)
    when 'その他'
      janle = Janle.find_by(janle: janle_name)
      posts = janle.posts.order(created_at: :desc)
    end  

    return posts
  end

end
