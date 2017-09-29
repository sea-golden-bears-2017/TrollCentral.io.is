require 'spec_helper'

describe Vote do
  let (:question) {Question.new(question_text: "Where?", user_id: 0)}
  let (:vote) {Vote.new(user_id: 0, value: 1, voteable: question)}
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
      user = User.new(user_name: "KoolKat24")
      vote.user = user
      vote.save
      expect(Vote.find_by_id(vote.id).user).to eq(user)
    end
    it "can belong to an answer" do
      answer = Answer.new(answer_text: "Hey!", question_id: 0, user_id: 0)
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
