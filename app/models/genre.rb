class Genre < ApplicationRecord
  
  has_many :bands, dependent: :destroy
  
end
