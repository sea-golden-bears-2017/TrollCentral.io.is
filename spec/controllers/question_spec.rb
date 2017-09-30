require 'spec_helper'

describe "Questions Controller" do
  Question.destroy_all
  describe "get /questions" do
    it "returns 200" do
      get '/questions'
      expect(last_response.status).to eq(200)
    end
  end

  describe "questions show /questions/id" do
    before(:each){Question.destroy_all}
    let(:question) {Question.create!(question_text: "where?", user_id: 0)}
    before(:each) {get "/questions/#{question.id}"}
    it 'returns 200' do
      p Question.find(1)
      expect(last_response.status).to eq(200)
    end
    it 'displays question text' do
      expect(last_response.body).to include("where?")
    end
  end

  describe "post /questions" do
    it "it reroutes to landing page" do
      post '/questions', {question_text: "Nothing"}
      expect(last_response.location).to end_with("/questions")
    end
    it "it creates a new question on form submit" do
      expect{post '/questions', {question_text: "Nothing"}}.to change{Question.count}.by(1)
    end
  end

  describe "post /questions/:question_id/comments" do
    let(:question){Question.create!(question_text: "where?", user_id: 0)}

    it "reroutes to the question's show page" do
      post "/questions/#{question.id}/comments", {commentable_id: 1, commentable_type: 'Question', comment_text: "Nothing.", user_id: 0}
      expect(last_response.location).to end_with("/questions/#{question.id}")
    end

    it "creates a new comment on form submit" do
      expect{post "/questions/#{question.id}/comments", {commentable_id: 4, commentable_type: 'Question', comment_text: "Nothing.", user_id: 0}}.to change{Comment.count}.by(1)
    end
  end
end
