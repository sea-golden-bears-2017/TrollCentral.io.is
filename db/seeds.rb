users = Array.new(50) {nil}
users.map! {User.create!(user_name: Faker::Ancient.hero,
                        email: Faker::Internet.email,
                        password: "test")}

questions = Array.new(50) {nil}
questions.map! {Question.create!(question_text: Faker::HeyArnold.quote,
                                  user: users.sample)}

answers = Array.new(200) {nil}
answers.map! {Answer.create!(answer_text: Faker::Lovecraft.sentence,
                              question: questions.sample, user: users.sample)}

able = [questions, answers]

300.times do
  Comment.create!(comment_text: Faker::HarryPotter.quote,
                                commentable: able.sample.sample,
                                user: users.sample)
end

values = [1, -1, 1, 1, 1]

500.times do
  Vote.create!(user: users.sample, value: values.sample,
                voteable: able.sample.sample)
end
