class Genre < ApplicationRecord
  
  has_many :bands, dependent: :destroy
  
  validates :name, presence: true
  
end
