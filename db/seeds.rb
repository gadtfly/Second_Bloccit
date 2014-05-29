require 'faker'

#create users as per bloc instruccions
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation! 
  user.save
end
users = User.all 

#create posts
50.times do 
  Post.create(
    user:  users.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )  
end
posts = Post.all

#create comments
100.times do 
  Comment.create(
    #user: users.sample,        ####we have not yet associated user with comment?????
    post: posts.sample,
    body: Faker::Lorem.paragraph
    )
end

User.first.update_attributes(
  email: 'youremail.com',
  password: 'helloworld',
  )

puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
