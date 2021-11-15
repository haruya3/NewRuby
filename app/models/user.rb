class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  
  has_many :posts

  has_many :likes
  has_many :post_likes, through: :likes, source: :post

  mount_uploader :user_image, ImageUploader

  validates :username, {uniqueness: true, presence: true, length: {maximum: 15}}

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
      
    unless user
      user = User.create(
      uid:      auth.uid,
      provider: auth.provider,
      email:    auth.info.email,
      name:     auth.info.name,
      password: Devise.friendly_token[0, 20]#開発者にも分からないようにランダムなパスワードが作られる。
    )
    end
    user
  end

end
