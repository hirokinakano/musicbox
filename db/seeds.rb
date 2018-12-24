Artist.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = "example-#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  Artist.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

artists = Artist.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.sentence(3)
  artists.each { |artist| artist.posts.create!(content: content, title: title) }
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?