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

Genre.create([
    {name: "Rock"},
    {name: "Pops"},
    {name: "Jazz"},
    {name: "Heavy Metal"},
    {name: "Anime"}
  ])

Motivation.create([
    {name: "Professional"},
    {name: "amateur(活動は週１回程度)"},
    {name: "amateur(活動は月１回程度)"}
  ])

MusicalInstrument.create([
    {name: "Vocal"},
    {name: "Guiter"},
    {name: "Bass"},
    {name: "Drum"},
    {name: "Keyboard"}
  ])

vocal = User.find_or_create_by!(email: "vocal@example.com") do |user|
  user.name = "めぇちゃん"
  user.password = "aaaaaa"
  user.musical_instrument_id = 1
  user.motivation_id = 1
  user.introduction = "歌います"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/vocal.jpg"), filename: "vocal.jpg")
end

guiter = User.find_or_create_by!(email: "guiter@example.com") do |user|
  user.name = "おゆき"
  user.password = "aaaaaa"
  user.musical_instrument_id = 2
  user.motivation_id = 1
  user.introduction = "歌い、弾きます"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/guiter.jpg"), filename: "guiter.jpg")
end

guiter2 = User.find_or_create_by!(email: "guiter2@example.com") do |user|
  user.name = "しょーにぃ"
  user.password = "aaaaaa"
  user.musical_instrument_id = 2
  user.motivation_id = 1
  user.introduction = "歌い、笑い、弾きます"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/guiter2.jpg"), filename: "guiter2.jpg")
end

bass = User.find_or_create_by!(email: "bass@example.com") do |user|
  user.name = "あっちゃん"
  user.password = "aaaaaa"
  user.musical_instrument_id = 3
  user.motivation_id = 1
  user.introduction = "低音響かせます"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/bass.jpg"), filename: "bass.jpg")
end

drum = User.find_or_create_by!(email: "drum@example.com") do |user|
  user.name = "BOSS"
  user.password = "aaaaaa"
  user.musical_instrument_id = 4
  user.motivation_id = 1
  user.introduction = "叩きます"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/drum.jpg"), filename: "drum.jpg")
end

keyboard = User.find_or_create_by!(email: "keyboard@example.com") do |user|
  user.name = "むーさん"
  user.password = "aaaaaa"
  user.musical_instrument_id = 5
  user.motivation_id = 1
  user.introduction = "弾きます"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/keyboard.jpg"), filename: "keyboard.jpg")
end

Post.find_or_create_by!(id: 1) do |post|
  post.body = "イベント開催します！"
  post.user = vocal
end

Post.find_or_create_by!(id: 2) do |post|
  post.body = "新しいギター欲しいな…"
  post.user = guiter
end

Post.find_or_create_by!(id: 3) do |post|
  post.body = "〇〇が最近のお気に入りです"
  post.user = guiter2
end

Post.find_or_create_by!(id: 4) do |post|
  post.body = "カバーしたい曲があります"
  post.user = bass
end

Post.find_or_create_by!(id: 5) do |post|
  post.body = "Rifoliaよろしくです！"
  post.user = drum
end

Post.find_or_create_by!(id: 6) do |post|
  post.body = "練習楽しい！"
  post.user = keyboard
end

