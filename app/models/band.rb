class Band < ApplicationRecord

  belongs_to :owner, class_name: "User"
  belongs_to :genre
  has_many :band_members, dependent: :destroy
  has_many :users, through: :band_members

  has_one_attached :band_image

  def is_owned_by?(user)
    owner.id == user.id
  end

  def include_user?(user)
    band_members.exists?(user_id: user.id)
  end

  def get_band_image
    (band_image.attached?) ? band_image: 'no_image.jpg'
  end

  def self.looks(model, search, word)
    if search == "partial_match"
      @band = Band.where("name LIKE?", "%#{word}%")
    elsif model == "Genre" && search == "partial_match"
      @band = Band.joins(:genre).where("genre.name LIKE?", "%#{word}%")
    else
      Band.all
    end
  end

end
