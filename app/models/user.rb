class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  
  belongs_to :musical_instrument
  belongs_to :motivation
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :band_members, dependent: :destroy
  has_many :band_permits, dependent: :destroy
  has_many :bands, through: :band_members
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :dm_rooms, through: :entries

  has_one_attached :profile_image


  def get_profile_image
    (profile_image.attached?) ? profile_image: "no_image.jpg"
  end

  def self.guest
    find_or_create_by!(email: "guest@guest") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guest"
      user.musical_instrument_id = 1
      user.motivation_id = 1
      user.introduction = "ゲストです"
    end
  end

  def self.looks(search, word)
    if search == "partial_match"
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end

  paginates_per 10

end
