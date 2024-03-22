# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |admin|
  admin.password = ENV["ADMIN_PASSWORD"]
end 

Genre.find_or_created_by!([
    {name: "Rock"},
    {name: "Pops"},
    {name: "Jazz"},
    {name: "Heavy Metal"},
    {name: "Anime"}
  ])

Motivation.find_or_created_by!([
    {name: "Professional"},
    {name: "amateur(活動は週１回程度)"},
    {name: "amateur(活動は月１回程度)"}
  ])
  
MusicalInstrument.find_or_created_by!([
    {name: "Vocal"},
    {name: "Guiter"},
    {name: "Bass"},
    {name: "Drum"},
    {name: "Keyboard"}
  ])

vocal = User.find_or_create_by!(email: "vocal@example.com") do |user|
  user.name = "めぇちゃん"
  user.password = "aaaaaa"
  user.musical_instrument = "Vocal"
  user.motivation = "Professional"
  user.introduction = "歌います"
end

guiter = User.find_or_create_by!(email: "guiter@example.com") do |user|
  user.name = "おゆき"
  user.password = "aaaaaa"
  user.musical_instrument = "Guiter"
  user.motivation = "Professional"
  user.introduction = "歌い、弾きます"
end

guiter2 = User.find_or_create_by!(email: "guiter2@example.com") do |user|
  user.name = "しょーにぃ"
  user.password = "aaaaaa"
  user.musical_instrument = "Guiter"
  user.motivation = "Professional"
  user.introduction = "歌い、笑い、弾きます"
end

bass = User.find_or_create_by!(email: "bass@example.com") do |user|
  user.name = "あっちゃん"
  user.password = "aaaaaa"
  user.musical_instrument = "Bass"
  user.motivation = "Professional"
  user.introduction = "低音響かせます"
end

drum = User.find_or_create_by!(email: "drum@example.com") do |user|
  user.name = "BOSS"
  user.password = "aaaaaa"
  user.musical_instrument = "Drum"
  user.motivation = "Professional"
  user.introduction = "叩きます"
end

keyboard = User.find_or_create_by!(email: "keyboard@example.com") do |user|
  user.name = "むーさん"
  user.password = "aaaaaa"
  user.musical_instrument = "Keyboard"
  user.motivation = "Professional"
  user.introduction = "弾きます"
end

