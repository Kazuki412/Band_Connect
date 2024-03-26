class DmRoom < ApplicationRecord

  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :name, presence: true

end
