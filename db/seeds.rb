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

premium = User.new(
    email: "premium@bloc.com",
    password: "123456",
    role: "premium"
)
premium.skip_confirmation!
premium.save!


standard = User.new(
    email: "standard@bloc.com",
    password: "123456",
    role: "standard"
)
standard.skip_confirmation!
standard.save!


admin = User.new(
  email: "admin@bloc.com",
  password: "123456",
  role: "admin"
)
admin.skip_confirmation!
admin.save!


 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
