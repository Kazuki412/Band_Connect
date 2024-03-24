class MusicalInstrument < ApplicationRecord
  
  has_many :users
  
  validates :name, presence: true

end
