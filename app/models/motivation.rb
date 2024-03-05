class Motivation < ApplicationRecord
  
  has_many :users
  
  enum name: { professional: 0, amateur: 1, hobby: 2 }
  
end
