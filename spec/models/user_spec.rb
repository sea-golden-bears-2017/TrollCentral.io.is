require 'spec_helper'

describe User do
  let! (:user) {User.create!(user_name: "name")}
  let! (:question) {Question.create!(question_text: "question", user_id: user.id)}
  let! (:comment) {Comment.create!(comment_text: "comment", user_id: user.id,
                  commentable_type: "Question", commentable_id: question.id)}
  let! (:answer) {Answer.create!(answer_text: "answer", user_id: user.id, question_id: question.id)}
  describe "Validations" do
    it "needs to have a user_name" do
      user.user_name = ""
      user.save
      expect(user).to_not be_valid
    end
  end
  describe "Associations" do
    it "has many comments" do
      expect(user.comments.count).to eq(1)
    end
    it "has many questions" do
      expect(user.questions.count).to eq(1)
    end
    it "has many answers" do
      expect(user.answers.count).to eq(1)
    end
  end
end
