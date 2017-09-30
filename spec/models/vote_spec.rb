require 'spec_helper'

describe Vote do
  let (:user) {User.create(user_name: "Woody Guthrie")}
  let (:question) {Question.create(question_text: "Where?", user_id: user.id)}
  let (:vote) {Vote.create(user: user, value: 1, voteable: question)}
  describe "validations" do
    it "has a value of +1, -1, or 0" do
      vote.value = 2
      vote.save
      expect(vote).to_not be_valid
    end
    it "must have a voteable object" do
      vote.voteable = nil
      vote.save
      expect(vote).to_not be_valid
    end
  end
  describe "associations" do
    it "belongs to a user" do
      vote.user = user
      vote.save
      expect(Vote.find_by_id(vote.id).user).to eq(user)
    end
    it "can belong to an answer" do
      answer = Answer.new(answer_text: "Hey!", question_id: 0, user_id: user.id)
      vote.voteable = answer
      vote.save
      expect(Vote.find_by_id(vote.id).voteable).to eq(answer)
    end
    it "can belong to a question" do
      question = Question.new(question_text: "Where?", user_id: 0)
      vote.voteable = question
      vote.save
      expect(Vote.find_by_id(vote.id).voteable).to eq(question)
    end
  end
end
