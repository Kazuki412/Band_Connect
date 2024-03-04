class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  
  validates :user_id, uniqueness: {scope: :book_id}
end
