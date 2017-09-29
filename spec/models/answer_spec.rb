require 'spec_helper'

describe Answer do
  let! (:user) {User.create!(user_name: "name")}
  let! (:question) {Question.create!(question_text: "question", user_id: user.id)}
  let! (:answer) {Answer.create!(answer_text: "answer", user_id: user.id, question_id: question.id)}
  let! (:comment) {Comment.create!(comment_text: "comment", user_id: user.id,
                  commentable_type: "Answer", commentable_id: answer.id)}

  describe "Validations" do
    it "needs to have a answer_text" do
      answer.answer_text = ""
      answer.save
      expect(answer).to_not be_valid
    end
    it "must have a user id" do
      question.user_id = nil
      question.save
      expect(question).to_not be_valid
    end
  end
  describe "Associations" do
    it "belongs to a question" do
      expect(answer.question).to eq(question)
    end
    it "has many comments" do
      expect(answer.comments.count).to eq(1)
    end
    it "belongs to a user" do
      expect(answer.user).to eq(user)
    end
  end
end
