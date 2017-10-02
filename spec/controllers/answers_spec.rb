require 'spec_helper'

describe "answers_controller" do
  let (:question) {Question.create!(question_text: "where?", user_id: 0)}

  describe "questions show / answers index" do
    before(:each) {get "/questions/#{question.id}"}
    it 'returns 200' do
      expect(last_response.status).to eq(200)
    end
    it 'displays question text' do
      expect(last_response.body).to include("where?")
    end
  end

  describe "answers create" do
    before(:each) {post "/questions/#{question.id}/answers", {answer: {answer_text:
      "here", question_id: question.id, user_id: 0}}}
    it 'returns 302' do
      expect(last_response.status).to eq(302)
    end
    it 'redirects to questions show page' do
      expect(last_response.location).to end_with("/#{question.id}")
    end
    it 'creates a new answer' do
      expect(Answer.find_by_answer_text("here")).to_not be_nil
    end
  end

  describe "new answer comment" do
    let (:user) {User.create!(user_name: "name", email: "hi@hi.com", password_hash: 'password')}
    let (:question) {Question.create!(question_text: "question", user_id: user.id)}
    let (:answer) {Answer.create!(answer_text: "answer", user_id: user.id, question_id: question.id)}
    let(:post_comment) {post "/questions/#{question.id}/answers/#{answer.id}/comments", {answer_id: answer.id, comment_text: "Hi"}, "rack.session" => {user_id: user.id}}
    context "when user is logged in" do
      it "returns 302" do
        post_comment
        expect(last_response.status).to eq(302)
      end
      it "creates a new comment on answer" do
        post_comment
        expect(Answer.find(answer.id).comments.pluck(:comment_text)).to include("Hi")
      end
    end
    context "when user is not logged in" do
      it "returns 404" do
        post "/questions/#{question.id}/answers/#{answer.id}/comments", {answer_id: answer.id, comment_text: "Hi"}
        expect(last_response.status).to eq(404)
      end
    end
  end
end
