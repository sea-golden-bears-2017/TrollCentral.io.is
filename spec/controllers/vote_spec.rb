require 'spec_helper'

describe "Vote Controller" do
  let (:user) {User.create(user_name: "Woody Guthrie")}
  let (:question) {Question.create(question_text: "Where?", user_id: user.id)}
  describe "post ../votes" do
    context "upvote on a question" do
      it "returns 302" do
        expect(last_response.status).to eq(302)
      end
      it "redirects to question show page" do
        expect(last_response.location).to end_with()
      end
    end
    context "downvote on a question" do

    end
    context "user is not logged in" do

    end
  end
end
