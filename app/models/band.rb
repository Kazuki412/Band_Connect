class Band < ApplicationRecord

  belongs_to :owner, class_name: "User"
  belongs_to :genre
  has_many :band_members, dependent: :destroy
  has_many :users, tyrough: :group_users
  
  has_one_attached :band_image
end
