class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :motivation
  belongs_to :musical_instrument
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bands, through: :band_members
  has_many :band_members, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :dm_rooms, through: :entries

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image: "no_image.jpg"
  end
end
