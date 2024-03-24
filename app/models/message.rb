class Message < ApplicationRecord
  
  belongs_to :user
  belongs_to :dm_room
  
  validates :content, presence: true
end
