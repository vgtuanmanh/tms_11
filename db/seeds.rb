User.create!(name:  "Example User",
             email: "abc@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true)

16.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name,
              email: email,
              password:              password,
              password_confirmation: password,
              admin:    true)
end

Course.create! name: "Traning Basic Ruby",
                        description: "For HEDSPI K55 - HUST by Sensei",
                        begin_at: "2016-01-08",
                        end_at:   "2017-02-15"

CourseUser.create! user_id: User.first.id, course_id: Course.first.id