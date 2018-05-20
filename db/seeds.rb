require 'faker'

30.times do
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Internet.password(8)
  )
end
users = User.all

30.times do
  Wiki.create!(
  user: users.sample,
  title: Faker::Pokemon.name,
  body: Faker::OnePiece.akuma_no_mi
  )
end
wikis = Wiki.all


 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
