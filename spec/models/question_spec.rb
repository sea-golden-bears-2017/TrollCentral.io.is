require 'spec_helper'

describe Question do
  let! (:user) {User.create!(user_name: "name")}
  let! (:question) {Question.create!(question_text: "question", user_id: user.id)}
  let! (:comment) {Comment.create!(comment_text: "comment", user_id: user.id,
                  commentable_type: "Question", commentable_id: question.id)}
  let! (:answer) {Answer.create!(answer_text: "answer", user_id: user.id, question_id: question.id)}
  describe "Validations" do
    it "needs to have a question_text" do
      question.question_text = ""
      question.save
      expect(question).to_not be_valid
    end
    it "must have a user id" do
      question.user_id = nil
      question.save
      expect(question).to_not be_valid
    end
  end
  describe "Associations" do
    it "has many answers" do
      expect(question.answers.count).to eq(1)
    end
    it "has many comments" do
      expect(question.comments.count).to eq(1)
    end
    it "belongs to a user" do
      expect(question.user).to eq(user)
    end
  end
end
