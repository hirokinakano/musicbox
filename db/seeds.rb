Artist.create!(name:                  "Example User",
               email:                 "example@railstutorial.org",
               password:              "foobar",
               password_confirmation: "foobar",
               admin:                 true,
               content:               "Hello World",
               image: FIle.open("./app/assets/images/1.jpg") )


5.times do |n|
  name  = "example-#{n+1}"
  email = "example-#{n+1}@rails.com"
  password = "password"
  content = "Hello World!"
  n += 1
  Artist.create!(name:                  name,
                 email:                 email,
                 password:              password,
                 password_confirmation: password,
                 content:               content,
                 image: File.open("./app/assets/images/#{n+1}.jpg") )
end

artists = Artist.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.sentence(3)
  artists.each { |artist| artist.posts.create!(content: content, title: title) }
end

#active_adminの管理者アカウントを作成
AdminUser.create!(email: 'admin@example.com', 
                  password: 'password', 
                  password_confirmation: 'password') if Rails.env.development?