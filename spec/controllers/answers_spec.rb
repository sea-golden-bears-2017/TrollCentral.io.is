require 'spec_helper'

describe "answers_controller" do
  let (:question) {Question.create!(question_text: "where?", user_id: 0)}
  describe "questions show / answers index" do
    before(:each) {get "/questions/#{question.id}/answers"}
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
      expect(last_response.location).to end_with("/answers")
    end
    it 'creates a new answer' do
      expect(Answer.find_by_answer_text("here")).to_not be_nil
    end
  end
end
