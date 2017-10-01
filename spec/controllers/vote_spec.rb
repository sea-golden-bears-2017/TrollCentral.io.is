require 'spec_helper'

describe "Vote Controller" do
  let (:user) {User.create(user_name: "Woody Guthrie")}
  let (:question) {Question.create(question_text: "Where?", user_id: user.id)}
  describe "post ../votes" do
    context "upvote on a question" do
      let(:upvote) {post "/questions/#{question.id}/votes", {vote_val: 1, type: "question", user_id: user.id}}
      it "returns 302" do
        upvote
        expect(last_response.status).to eq(302)
      end
      it "redirects to question show page" do
        upvote
        expect(last_response.location).to end_with("#{question.id}")
      end
      it "increments vote count on question by one" do
        ## Value stores either +1 or -1 for each vote
        ## Find all the votes for one question, get the value for that vote,
        ## Take the sum of those values using reduce
        ## Append to_i to the end because reduce returns nil when there are no values present
        ## nil.to_i = 0
        old_total = Question.find(question.id).votes.pluck(:value).reduce(:+).to_i
        upvote
        new_total = Question.find(question.id).votes.pluck(:value).reduce(:+).to_i
        expect(old_total).to eq(new_total - 1)
      end
    end
    context "downvote on a question" do
      let(:downvote) {post "/questions/#{question.id}/votes", {vote_val: -1, type: "question", user_id: user.id}}
      it "returns 302" do
        downvote
        expect(last_response.status).to eq(302)
      end
      it "redirects to question show page" do
        downvote
        expect(last_response.location).to end_with("#{question.id}")
      end
      it "decrements vote count on question by one" do
        ## See line 18 for explanation
        old_total = Question.find(question.id).votes.pluck(:value).reduce(:+).to_i
        downvote
        new_total = Question.find(question.id).votes.pluck(:value).reduce(:+).to_i
        expect(old_total).to eq(new_total + 1)
      end
    end
    context "user is not logged in" do
      xit "returns 404"
    end
  end
end
