# メインのサンプルユーザーを1人作成する
User.create!(name:  "psycho-logic",
             email: "kumagaijirou1981@gmail.com",
             password:              "purindaisuki1109",
             password_confirmation: "purindaisuki1109",
             dice_point: "10000",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "kumagaijirou",
             email: "kumagaijirou0824@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             dice_point: "10000",
             admin:     false,
             activated: true,
             activated_at: Time.zone.now)             


# 追加のユーザーをまとめて生成する
#99.times do |n|
#  name  = Faker::Name.name,
#  email = "example-#{n+1}@railstutorial.org",
#  password = "password",
#  User.create!(name:  name,
#               email: email,
#               password:              "password",
#               password_confirmation: "password",
#               dice_point: "0",
#               activated: true,
#               activated_at: Time.zone.now)
#end

#タスクを生成する
#Task.create!(content: "programming",
#            user_id: 1,
#            bet_user_id: 2,
#            deadline_at: Time.zone.now,
#            amount_bet: 2000)