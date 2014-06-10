require 'faker'

#create users 
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

#crearemos los topics
105.times do
  Topic.create(
    name:            Faker::Lorem.sentence,
    description:     Faker::Lorem.paragraph
  )
end
topics = Topic.all 

#create posts
1950.times do 
  Post.create(
    user:  users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )  
end
posts = Post.all

#create comments
2000.times do 
  comment = Comment.create(
    user: users.sample,               
    post: posts.sample,
    body: Faker::Lorem.paragraph
    )
  comment.update_attribute(:created_at, rand(10.minutes..1.year).ago)
end

#crearemos un usuario administrador
admin = User.new(
  name:       'Admin User',
  email:      'admin@example.com',
  password:   'pepepepe',
  role:       'admin'
  )
admin.skip_confirmation!
admin.save

#crearemos un usuario moderador
moderator = User.new(
  name:       'Moderator User',
  email:      'moderator@example.com',
  password:   'pepepepe',
  role:       'moderator'
  )
moderator.skip_confirmation!
moderator.save

#crearemos un miembro
member = User.new(
  name:       'Member User',
  email:      'member@example.com',
  password:   'pepepepe',
  )
member.skip_confirmation!
member.save

puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
