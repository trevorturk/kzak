require 'machinist/active_record'
require 'sham'
require 'populator'
require 'faker'

Sham.login { "#{Faker::Name.first_name}_#{Faker::Name.last_name}".gsub(/'/, '')[0,15].downcase }
Sham.sentence { Faker::Lorem.sentence }
Sham.sentences { Faker::Lorem.sentences(rand(10) + 1) }
Sham.paragraphs { Faker::Lorem.paragraphs }
Sham.mp3 { File.open("#{Rails.root}/test/fixtures/files/audio.mp3") }
Sham.email { Faker::Internet.email }

FeedItem.blueprint do
  post { Post.make }
  user { User.make }
  post_id { post.id }
  poster_id { post.user_id }
  post_created_at { post.created_at }
end

Follow.blueprint do
  follower { User.make }
  following { User.make }
end

Invitation.blueprint do
  user { User.make }
  email { Sham.email }
end

Post.blueprint do
  user { User.make }
  mp3 { Sham.mp3 }
end

User.blueprint do
  login { Sham.login }
  email { Sham.email }
  password 'test'
end
