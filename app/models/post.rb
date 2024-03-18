class Post < ApplicationRecord
  
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "partial_match"
      @post = Post.where("body LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end
  
  paginates_per 10


end
