class Janle < ApplicationRecord
    has_many :post_janles 
    has_many :posts, through: :post_janles

    validates :janle, {presence: true}
end
