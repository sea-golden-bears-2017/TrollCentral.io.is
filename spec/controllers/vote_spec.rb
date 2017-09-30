require 'spec_helper'

describe "Vote Controller" do
  let (:user) {User.create(user_name: "Woody Guthrie")}
  let (:question) {Question.create(question_text: "Where?", user_id: user.id)}
  describe "post ../votes" do
    context "upvote on a question" do
      let(:upvote) {post "/questions/#{question.id}/votes", {vote_val: 1}}
      it "returns 302" do
        upvote
        expect(last_response.status).to eq(302)
      end
      it "redirects to question show page" do
        upvote
        expect(last_response.location).to end_with("#{question.id}")
      end
      it "increments vote count on question by one" do
        expect{upvote}.to change{question.votes.count}.by(1)
      end
    end
    context "downvote on a question" do
      let(:downvote) {post "/questions/#{question.id}/votes", {vote_val: -1}}
      it "returns 302" do
        downvote
        expect(last_response.status).to eq(302)
      end
      it "redirects to question show page" do
        downvote
        expect(last_response.location).to end_with("#{question.id}")
      end
      it "decrements vote count on question by one" do
        expect{downvote}.to change{question.votes.count}.by(-1)
      end
    end
    context "user is not logged in" do
      it "returns 404"
    end
  end
end
