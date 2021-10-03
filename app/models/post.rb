class Post < ApplicationRecord
    belongs_to :user
    mount_uploader :post_image, ImageUploader

    validates :title, {presence: true, length: {maximum: 15}}
    validates :content, {presence: true, length: {maximum: 140}}
    validates :post_image, {presence: true}
    validates :user_id, {presence: true}



end
