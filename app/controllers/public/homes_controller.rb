class Public::HomesController < ApplicationController
  
  def top
  end
  
  def guest_sign_in
    user = User.find_or_create_by!(email: "guest@guest") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guest"
      user.musical_instrument = MusicalInstrument.find_by(name: "Vocal")
      user.motivation = Motivation.find_by(name: "Professional")
      user.introduction = "ゲストです"
    end 
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end 
  
end
