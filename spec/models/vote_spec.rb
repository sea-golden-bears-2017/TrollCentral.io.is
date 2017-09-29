require 'spec_helper'

describe Vote do
  let (:vote) {Vote.create(user_id: 0, value: 1)}
  describe "validations" do
    it "has a value of +1, -1, or 0" do
      vote.value = 2
      vote.save
      expect(vote).to_not be_valid
    end
  end
  describe "associations" do
    it "belongs to a user" do
      user = User.new(user_name: "KoolKat24")
      vote.user << user
      expect(Vote.find_by_id(vote.id).user).to eq(user)
    end
    it "can belong to an answer" do
      answer = Answer.new(answer_text: "Hey!", question_id: 0, user_id: 0)
      vote.voteable << answer
      expect(Vote.find_by_id(vote.id).voteable).to eq(answer)
    end
    it "can belong to a question" do
      question = Question.new(question_text: "Where?", user_id: 0)
      vote.voteable << question
      expect(Vote.find_by_id(vote.id).voteable).to eq(question)
    end
  end
end
