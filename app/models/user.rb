require 'uri'
require 'net/http'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :line]
  
  has_many :posts

  has_many :likes
  has_many :post_likes, through: :likes, source: :post

  mount_uploader :user_image, ImageUploader

  validates :username, {uniqueness: true, presence: true, length: {maximum: 15}}

  def self.find_for_oauth(auth, code)
    id_token = User.get_id_token(code)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    if user == nil
      user = User.new(
      uid:      auth.uid,
      provider: auth.provider,
      email:    id_token[0][:email],
      username: auth.info.name,
      password: Devise.friendly_token[0, 20]#開発者にも分からないようにランダムなパスワードが作られる。
      )
    elsif user.email == nil #userアカウント持っていて途中からsns認証使う場合
      user = User.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    user.skip_confirmation!
    user.save
    user
  end

  def self.get_id_token(code)
    uri = URI.parse("https://api.line.me/oauth2/v2.1/token")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/x-www-form-urlencoded"
    request.set_form_data(
      "client_id" => ENV["LINE_APP_ID"],
      "client_secret" => ENV["LINE_APP_SECRET"],
      "code" => "#{code}",
      "grant_type" => "authorization_code",
      "redirect_uri" => "https://spot-share-site.herokuapp.com//users/sign_up",
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    return JWT.decode(JSON.parse(response.body)["id_token"], ENV[LINE_APP_SECRET])
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
